import 'package:flutter/material.dart';
import '../models/daily_log.dart';
import '../core/theme.dart';

class DailySectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Map<String, bool> checklist;
  final Function(String) onToggle;
  final String? reflectionValue;
  final Function(String)? onReflectionChanged;
  final String? reflectionLabel;
  final Color color;

  const DailySectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.checklist,
    required this.onToggle,
    this.reflectionValue,
    this.onReflectionChanged,
    this.reflectionLabel,
    this.color = AppTheme.primaryTeal,
  });

  @override
  Widget build(BuildContext context) {
    final completed = checklist.values.where((v) => v).length;
    final total = checklist.length;
    final progress = total > 0 ? completed / total : 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: color,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.2),
                  child: Text(
                    '$completed/$total',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Progress bar
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 16),

            // Checklist
            ...checklist.entries.map((entry) {
              return CheckboxListTile(
                title: Text(
                  entry.key,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        decoration: entry.value
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: entry.value ? Colors.white38 : Colors.white70,
                      ),
                ),
                value: entry.value,
                onChanged: (_) => onToggle(entry.key),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                dense: true,
                activeColor: color,
              );
            }).toList(),

            // Reflection field
            if (onReflectionChanged != null) ...[
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: reflectionLabel,
                  labelStyle: TextStyle(color: color),
                  hintText: 'Add your thoughts...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: color, width: 2),
                  ),
                ),
                controller: TextEditingController(text: reflectionValue),
                onChanged: onReflectionChanged,
                maxLines: 3,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
