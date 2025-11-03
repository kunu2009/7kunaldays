import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import '../providers/theme_provider.dart';

class PlannerTimelineScreen extends ConsumerStatefulWidget {
  const PlannerTimelineScreen({super.key});

  @override
  ConsumerState<PlannerTimelineScreen> createState() => _PlannerTimelineScreenState();
}

class _PlannerTimelineScreenState extends ConsumerState<PlannerTimelineScreen> {
  Timer? _timer;
  int _secondsRemaining = 25 * 60; // 25 minutes
  bool _isRunning = false;
  bool _isBreak = false;
  
  final List<Map<String, dynamic>> timeBlocks = [
    {'time': '6:00 AM', 'title': 'Wake up + Water + Hygiene', 'type': 'routine', 'completed': false},
    {'time': '6:20 AM', 'title': 'Morning Workout', 'type': 'fitness', 'completed': false},
    {'time': '7:15 AM', 'title': 'Bath + Breakfast', 'type': 'meal', 'completed': false},
    {'time': '8:00 AM', 'title': 'Deep Study Block 1 – History', 'type': 'study', 'completed': false},
    {'time': '10:15 AM', 'title': 'Deep Study Block 2 – Constitution/Legal Aptitude', 'type': 'study', 'completed': false},
    {'time': '12:30 PM', 'title': 'Lunch + Rest', 'type': 'meal', 'completed': false},
    {'time': '2:30 PM', 'title': 'Practice / Revision Block (Economics/English)', 'type': 'study', 'completed': false},
    {'time': '5:30 PM', 'title': 'Evening Mobility + Snack', 'type': 'fitness', 'completed': false},
    {'time': '6:30 PM', 'title': 'Brand work / Content creation', 'type': 'brand', 'completed': false},
    {'time': '8:00 PM', 'title': 'Light reading / Review', 'type': 'study', 'completed': false},
    {'time': '9:30 PM', 'title': 'Reflection + Journal', 'type': 'reflection', 'completed': false},
    {'time': '10:45 PM', 'title': 'Sleep', 'type': 'routine', 'completed': false},
  ];

  void _addTimeBlock() {
    final timeController = TextEditingController();
    final titleController = TextEditingController();
    String selectedType = 'routine';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add Time Block'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  hintText: 'e.g., 6:00 AM',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Activity',
                  hintText: 'e.g., Morning Workout',
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedType,
                decoration: const InputDecoration(
                  labelText: 'Type',
                ),
                items: const [
                  DropdownMenuItem(value: 'routine', child: Text('Routine')),
                  DropdownMenuItem(value: 'study', child: Text('Study')),
                  DropdownMenuItem(value: 'fitness', child: Text('Fitness')),
                  DropdownMenuItem(value: 'brand', child: Text('7K Brand')),
                  DropdownMenuItem(value: 'college', child: Text('College')),
                  DropdownMenuItem(value: 'reflection', child: Text('Reflection')),
                ],
                onChanged: (value) {
                  setDialogState(() {
                    selectedType = value!;
                  });
                },
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
                if (timeController.text.isNotEmpty && titleController.text.isNotEmpty) {
                  setState(() {
                    timeBlocks.add({
                      'time': timeController.text,
                      'title': titleController.text,
                      'type': selectedType,
                      'completed': false,
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

  bool _isCurrentTimeBlock(String timeStr) {
    try {
      final now = DateTime.now();
      final parts = timeStr.split(' ');
      if (parts.length != 2) return false;
      
      final timeParts = parts[0].split(':');
      if (timeParts.length != 2) return false;
      
      int hour = int.parse(timeParts[0]);
      final isPM = parts[1].toUpperCase() == 'PM';
      
      if (isPM && hour != 12) hour += 12;
      if (!isPM && hour == 12) hour = 0;
      
      final currentHour = now.hour;
      // Highlight if within 1 hour of the time block
      return (currentHour >= hour - 1 && currentHour <= hour + 1);
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() => _isRunning = false);
    } else {
      setState(() => _isRunning = true);
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_secondsRemaining > 0) {
          setState(() => _secondsRemaining--);
        } else {
          _timer?.cancel();
          setState(() {
            _isRunning = false;
            _isBreak = !_isBreak;
            _secondsRemaining = _isBreak ? 5 * 60 : 25 * 60;
          });
          _showCompletionDialog();
        }
      });
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _secondsRemaining = 25 * 60;
      _isBreak = false;
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_isBreak ? '☕ Break Time!' : '🎯 Session Complete!'),
        content: Text(_isBreak
            ? 'Take a 5-minute break. You earned it!'
            : 'Great work! Ready for the next session?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _toggleTimer();
            },
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }

  Color _getBlockColor(String type, AppThemeMode mode) {
    switch (type) {
      case 'study':
        return AppTheme.getStudyColor(mode);
      case 'fitness':
        return AppTheme.getFitnessColor(mode);
      case 'brand':
        return AppTheme.getBrandColor(mode);
      case 'college':
        return AppTheme.getConfidenceColor(mode);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('PLANNER & TIMELINE'),
      ),
      body: Column(
        children: [
          // Pomodoro Timer
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    _isBreak ? '☕ BREAK TIME' : '🍅 POMODORO TIMER',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 180,
                          height: 180,
                          child: CircularProgressIndicator(
                            value: _secondsRemaining / (_isBreak ? 5 * 60 : 25 * 60),
                            strokeWidth: 12,
                            backgroundColor: Colors.white12,
                            valueColor: AlwaysStoppedAnimation(
                              _isBreak
                                  ? AppTheme.getBrandColor(themeMode)
                                  : AppTheme.getFitnessColor(themeMode),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              _isBreak ? 'Break' : 'Focus',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _toggleTimer,
                        icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                        label: Text(_isRunning ? 'Pause' : 'Start'),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton.icon(
                        onPressed: _resetTimer,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Timeline
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '📅 TODAY\'S TIMELINE',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: AppTheme.primaryTeal),
                  onPressed: _addTimeBlock,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: timeBlocks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_note, size: 64, color: Colors.white24),
                        const SizedBox(height: 16),
                        Text(
                          'No time blocks yet',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white54,
                              ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _addTimeBlock,
                          icon: const Icon(Icons.add),
                          label: const Text('Add First Block'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: timeBlocks.length,
                    itemBuilder: (context, index) {
                      final block = timeBlocks[index];
                      final color = _getBlockColor(block['type'], themeMode);
                      final isCurrent = _isCurrentTimeBlock(block['time']);
                      
                      return Dismissible(
                        key: Key('block_$index'),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) {
                          setState(() {
                            timeBlocks.removeAt(index);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              // Time
                              Container(
                                width: 80,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isCurrent ? color.withOpacity(0.2) : null,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  block['time'],
                                  style: TextStyle(
                                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                                    color: isCurrent ? color : null,
                                  ),
                                ),
                              ),

                              // Timeline indicator
                              Column(
                                children: [
                                  Container(
                                    width: isCurrent ? 20 : 16,
                                    height: isCurrent ? 20 : 16,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: block['completed'] ? color : (isCurrent ? color.withOpacity(0.5) : Colors.transparent),
                                      border: Border.all(
                                        color: color,
                                        width: isCurrent ? 3 : 2,
                                      ),
                                    ),
                                  ),
                                  if (index < timeBlocks.length - 1)
                                    Container(
                                      width: 2,
                                      height: 40,
                                      color: isCurrent ? color : color.withOpacity(0.3),
                                    ),
                                ],
                              ),

                              const SizedBox(width: 16),

                              // Block card
                              Expanded(
                                child: Card(
                                  color: isCurrent ? color.withOpacity(0.15) : null,
                                  elevation: isCurrent ? 4 : 1,
                                  child: ListTile(
                                    title: Text(
                                      block['title'],
                                      style: TextStyle(
                                        decoration: block['completed']
                                            ? TextDecoration.lineThrough
                                            : null,
                                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                    subtitle: isCurrent
                                        ? Text(
                                            '⏰ CURRENT BLOCK',
                                            style: TextStyle(
                                              color: color,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        : null,
                                    trailing: Checkbox(
                                      value: block['completed'],
                                      onChanged: (value) {
                                        setState(() {
                                          block['completed'] = value ?? false;
                                        });
                                      },
                                    ),
                                    dense: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
