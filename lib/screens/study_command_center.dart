import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../core/theme.dart';
import 'study_material_screen.dart';

class StudyCommandCenter extends ConsumerStatefulWidget {
  const StudyCommandCenter({super.key});

  @override
  ConsumerState<StudyCommandCenter> createState() => _StudyCommandCenterState();
}

class _StudyCommandCenterState extends ConsumerState<StudyCommandCenter> {
  String _selectedSubject = 'History';
  bool _isStudying = false;
  int _timerSeconds = 0;
  Timer? _timer;
  int _focusPercentage = 100;

  final List<String> _subjects = [
    'History',
    'Political Science',
    'Economics',
    'English',
    'Hindi',
    'Sanskrit',
    'Legal Aptitude + Constitution',
  ];

  final Map<String, double> _subjectProgress = {
    'History': 0.0,
    'Political Science': 0.0,
    'Economics': 0.0,
    'English': 0.0,
    'Hindi': 0.0,
    'Sanskrit': 0.0,
    'Legal Aptitude + Constitution': 0.0,
  };

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isStudying = true;
      _timerSeconds = 0;
      _focusPercentage = 100;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timerSeconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isStudying = false;
    });

    // Show AI feedback
    _showFeedbackDialog();
  }

  void _showFeedbackDialog() {
    final minutes = _timerSeconds ~/ 60;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎯 Session Complete'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Subject: $_selectedSubject'),
            const SizedBox(height: 8),
            Text('Duration: $minutes minutes'),
            const SizedBox(height: 8),
            Text('Focus: $_focusPercentage%'),
            const SizedBox(height: 16),
            Text(
              _getFeedbackMessage(),
              style: TextStyle(
                color: AppTheme.primaryTeal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  String _getFeedbackMessage() {
    final minutes = _timerSeconds ~/ 60;
    if (minutes >= 90 && _focusPercentage >= 85) {
      return 'Excellent deep focus session! You maintained ${_focusPercentage}% focus.';
    } else if (minutes >= 60) {
      return 'Good work! Aim for 90+ min sessions for deep mastery.';
    } else {
      return 'Keep building focus endurance. Target: 90-120 min blocks.';
    }
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 STUDY COMMAND CENTER'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Show study history
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Exam Target Card
          Card(
            color: AppTheme.studyColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.school, color: AppTheme.studyColor, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'MHCET 5-Year LLB',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppTheme.studyColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Target Rank',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white60,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Under 50 AIR',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppTheme.studyColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Preparation Level',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white60,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '45%',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppTheme.studyColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Exam Date',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white60,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'May 2026',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppTheme.studyColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // AI Guidance Card
          Card(
            color: AppTheme.cardBackground,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.lightbulb, color: AppTheme.primaryTeal),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Today\'s Focus: Deep study on ${_selectedSubject}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Target: 6 hours total study today\n2-hour (120 min) deep focus blocks recommended',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Timer Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Subject Selector
                  DropdownButtonFormField<String>(
                    value: _selectedSubject,
                    decoration: const InputDecoration(
                      labelText: 'Select Subject',
                      border: OutlineInputBorder(),
                    ),
                    items: _subjects.map((subject) {
                      return DropdownMenuItem(
                        value: subject,
                        child: Text(subject),
                      );
                    }).toList(),
                    onChanged: _isStudying
                        ? null
                        : (value) {
                            if (value != null) {
                              setState(() => _selectedSubject = value);
                            }
                          },
                  ),
                  const SizedBox(height: 24),

                  // Timer Display
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppTheme.darkBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _isStudying ? AppTheme.primaryTeal : Colors.white24,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _formatTime(_timerSeconds),
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isStudying ? 'Deep Focus Mode 🎯' : 'Ready to Study',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Control Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _isStudying ? _stopTimer : _startTimer,
                          icon: Icon(_isStudying ? Icons.stop : Icons.play_arrow),
                          label: Text(_isStudying ? 'Stop Session' : 'Start Study'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isStudying ? AppTheme.fitnessColor : AppTheme.primaryTeal,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (_isStudying) ...[
                    const SizedBox(height: 16),
                    // Focus Slider
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Focus: $_focusPercentage%',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Slider(
                          value: _focusPercentage.toDouble(),
                          min: 0,
                          max: 100,
                          divisions: 20,
                          label: '$_focusPercentage%',
                          onChanged: (value) {
                            setState(() => _focusPercentage = value.round());
                          },
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Subject Progress
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subject Progress',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  ..._subjects.map((subject) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(subject),
                                Text('${_subjectProgress[subject]?.toStringAsFixed(0)}%'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: (_subjectProgress[subject] ?? 0) / 100,
                              backgroundColor: Colors.white12,
                              valueColor: AlwaysStoppedAnimation(
                                subject == 'Constitution' ? AppTheme.brandColor : AppTheme.studyColor,
                              ),
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Constitution Article Tracker
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '⚖️ Constitution Articles',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        '8/51',
                        style: TextStyle(
                          color: AppTheme.brandColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: 8 / 51,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation(AppTheme.brandColor),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Next: Article 9 - Persons voluntarily acquiring citizenship',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudyMaterialScreen(),
                        ),
                      );
                    },
                    child: const Text('Study Articles'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Quick Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudyMaterialScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.quiz),
                  label: const Text('Mock Test'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.cardBackground,
                    foregroundColor: AppTheme.primaryTeal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudyMaterialScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Revision'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.cardBackground,
                    foregroundColor: AppTheme.primaryTeal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
