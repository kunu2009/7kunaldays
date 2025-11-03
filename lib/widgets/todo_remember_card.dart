import 'package:flutter/material.dart';
import '../core/theme.dart';

class TodoRememberCard extends StatefulWidget {
  const TodoRememberCard({super.key});

  @override
  State<TodoRememberCard> createState() => _TodoRememberCardState();
}

class _TodoRememberCardState extends State<TodoRememberCard> {
  final List<Map<String, dynamic>> _todos = [
    {'text': 'Complete MHCET mock test', 'done': false, 'priority': 'high'},
    {'text': 'Revise Constitution Articles 1-11', 'done': false, 'priority': 'high'},
    {'text': 'Upload 7K content idea', 'done': false, 'priority': 'medium'},
  ];

  final List<String> _reminders = [
    '🎯 Target: Under 50 AIR MHCET',
    '💪 Workout streak: Keep it going!',
    '🧠 Focus. Consistency. Growth.',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '✅ TODO / Remember',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: AppTheme.primaryTeal),
                  onPressed: _showAddTodoDialog,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // TODOs
            ..._todos.map((todo) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: todo['done']
                        ? AppTheme.brandColor.withOpacity(0.2)
                        : AppTheme.darkBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: todo['priority'] == 'high'
                          ? AppTheme.brandColor
                          : Colors.white24,
                    ),
                  ),
                  child: CheckboxListTile(
                    value: todo['done'],
                    onChanged: (value) {
                      setState(() {
                        todo['done'] = value ?? false;
                      });
                    },
                    title: Text(
                      todo['text'],
                      style: TextStyle(
                        fontSize: 14,
                        decoration: todo['done']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: todo['done']
                            ? Colors.white54
                            : Colors.white,
                      ),
                    ),
                    secondary: todo['priority'] == 'high'
                        ? const Icon(Icons.priority_high, color: AppTheme.brandColor, size: 20)
                        : null,
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  ),
                )),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),

            // Reminders
            Text(
              '💡 Quick Reminders',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryTeal,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            ..._reminders.map((reminder) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.lightbulb_outline, size: 16, color: AppTheme.brandColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          reminder,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _showAddTodoDialog() {
    final textController = TextEditingController();
    String priority = 'medium';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: AppTheme.cardBackground,
          title: const Text('Add TODO'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: 'What needs to be done?',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Priority: '),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('High'),
                    selected: priority == 'high',
                    selectedColor: AppTheme.brandColor,
                    onSelected: (selected) {
                      setDialogState(() => priority = 'high');
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Medium'),
                    selected: priority == 'medium',
                    selectedColor: AppTheme.primaryTeal,
                    onSelected: (selected) {
                      setDialogState(() => priority = 'medium');
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  setState(() {
                    _todos.add({
                      'text': textController.text,
                      'done': false,
                      'priority': priority,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
