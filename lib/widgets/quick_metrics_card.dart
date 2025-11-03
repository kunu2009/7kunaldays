import 'package:flutter/material.dart';
import '../models/daily_log.dart';
import '../core/theme.dart';

class QuickMetricsCard extends StatelessWidget {
  final DailyLog log;

  const QuickMetricsCard({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📊 TODAY\'S METRICS',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _MetricItem(
                    icon: Icons.school,
                    label: 'Study',
                    value: '${log.metrics.studyHours.toStringAsFixed(1)}h',
                    color: AppTheme.studyColor,
                  ),
                ),
                Expanded(
                  child: _MetricItem(
                    icon: Icons.fitness_center,
                    label: 'Fitness',
                    value: '${log.metrics.fitnessMinutes}m',
                    color: AppTheme.fitnessColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _MetricItem(
                    icon: Icons.water_drop,
                    label: 'Water',
                    value: '${log.waterIntake.toStringAsFixed(1)}L',
                    color: AppTheme.brandColor,
                  ),
                ),
                Expanded(
                  child: _MetricItem(
                    icon: Icons.article,
                    label: 'Constitution',
                    value: '${log.constitutionProgress}/51',
                    color: AppTheme.confidenceColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _MetricItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
