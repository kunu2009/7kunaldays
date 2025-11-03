import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../core/theme.dart';

class ConfidenceLab extends ConsumerStatefulWidget {
  const ConfidenceLab({super.key});

  @override
  ConsumerState<ConfidenceLab> createState() => _ConfidenceLabState();
}

class _ConfidenceLabState extends ConsumerState<ConfidenceLab> {
  bool _isRecording = false;
  int _recordingSeconds = 0;
  Timer? _recordingTimer;
  int _mirrorTalkStreak = 0;
  int _todayRating = 7;

  final List<Map<String, dynamic>> _charismaChallenges = [
    {'emoji': '👋', 'title': 'Start 1 conversation daily', 'description': 'Approach someone & ask a question', 'completed': false},
    {'emoji': '🎥', 'title': 'Record & review 1 talking-head video', 'description': 'Fix posture/voice', 'completed': false},
    {'emoji': '💝', 'title': 'Compliment 2 people genuinely', 'description': 'Build social practice', 'completed': false},
    {'emoji': '😄', 'title': 'Tell a short story or joke to a friend', 'description': 'Practice storytelling', 'completed': false},
    {'emoji': '🎤', 'title': 'Speak up once in class/meeting', 'description': 'Practice assertiveness', 'completed': false},
  ];

  final List<String> _articulationExercises = [
    'The quick brown fox jumps over the lazy dog',
    'She sells seashells by the seashore',
    'Peter Piper picked a peck of pickled peppers',
    'How much wood would a woodchuck chuck',
    'I saw Susie sitting in a shoe shine shop',
  ];

  @override
  void dispose() {
    _recordingTimer?.cancel();
    super.dispose();
  }

  void _toggleRecording() {
    if (_isRecording) {
      _recordingTimer?.cancel();
      setState(() {
        _isRecording = false;
      });
      _showRecordingFeedback();
    } else {
      setState(() {
        _isRecording = true;
        _recordingSeconds = 0;
      });
      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _recordingSeconds++;
        });
      });
    }
  }

  void _showRecordingFeedback() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎤 Session Complete'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Duration: ${_recordingSeconds}s'),
            const SizedBox(height: 16),
            const Text('AI Feedback:'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '✅ Good pacing and clarity\n🎯 Maintain eye contact with mirror\n💡 Speak 10% slower for impact',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💬 CONFIDENCE LAB'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Stats Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text('🔥 Mirror Talk Streak'),
                        const SizedBox(height: 8),
                        Text(
                          '$_mirrorTalkStreak days',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.confidenceColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white24,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text('⭐ Confidence'),
                        const SizedBox(height: 8),
                        Text(
                          '$_todayRating/10',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.brandColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Confidence Assessment Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📊 Current Confidence Assessment',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  _buildConfidenceBar('Overall Confidence', 7),
                  const SizedBox(height: 12),
                  _buildConfidenceBar('Public Speaking', 6),
                  const SizedBox(height: 12),
                  _buildConfidenceBar('Body Language', 7),
                  const SizedBox(height: 12),
                  _buildConfidenceBar('Eye Contact', 8),
                  const SizedBox(height: 12),
                  _buildConfidenceBar('Voice Quality', 7),
                  const SizedBox(height: 12),
                  _buildConfidenceBar('Social Skills', 7),
                  const SizedBox(height: 12),
                  _buildConfidenceBar('Leadership', 6),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Mirror Talk
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🪞 Mirror Talk (3 min/day)',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Practice reciting goals or mock answers',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: _isRecording ? AppTheme.fitnessColor.withOpacity(0.2) : AppTheme.darkBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _isRecording ? AppTheme.fitnessColor : Colors.white24,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          _isRecording ? Icons.mic : Icons.mic_none,
                          size: 48,
                          color: _isRecording ? AppTheme.fitnessColor : Colors.white70,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _isRecording ? '${_recordingSeconds}s' : 'Ready',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: _isRecording ? AppTheme.fitnessColor : Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isRecording ? 'Recording...' : 'Tap to start practice',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _toggleRecording,
                    icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                    label: Text(_isRecording ? 'Stop Recording' : 'Start Practice'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isRecording ? AppTheme.fitnessColor : AppTheme.confidenceColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Articulation Exercises
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🗣️ Articulation Exercises',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Read out loud for clarity',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  ..._articulationExercises.map((exercise) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.darkBackground,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            exercise,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Charisma Challenges
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '⚡ Daily Charisma Challenges',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  if (_charismaChallenges.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Icon(Icons.psychology_outlined, size: 48, color: Colors.white24),
                          const SizedBox(height: 12),
                          Text(
                            'No challenges yet',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.white54,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add daily charisma challenges to track',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  else
                    ..._charismaChallenges.asMap().entries.map((entry) {
                      final challenge = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: challenge['completed'] ? AppTheme.confidenceColor.withOpacity(0.2) : AppTheme.darkBackground,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: challenge['completed'] ? AppTheme.confidenceColor : Colors.white24,
                            ),
                          ),
                          child: CheckboxListTile(
                            title: Row(
                              children: [
                                Text(
                                  challenge['emoji'],
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    challenge['title'],
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 32, top: 4),
                              child: Text(challenge['description']),
                            ),
                            value: challenge['completed'],
                            onChanged: (value) {
                              setState(() {
                                _charismaChallenges[entry.key]['completed'] = value ?? false;
                              });
                            },
                          ),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Principles
          Card(
            color: AppTheme.cardBackground,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.emoji_objects, color: AppTheme.primaryTeal),
                      const SizedBox(width: 12),
                      Text(
                        'Core Principles',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildPrinciple('Confidence = Evidence of discipline'),
                  _buildPrinciple('Speak slower. Pause more.'),
                  _buildPrinciple('Posture = Personality'),
                  _buildPrinciple('Keep spine tall, shoulders wide'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrinciple(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '•',
            style: TextStyle(
              color: AppTheme.primaryTeal,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfidenceBar(String label, int score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '$score/10',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryTeal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: score / 10,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              score >= 7 ? AppTheme.primaryTeal : (score >= 5 ? Colors.orange : Colors.red),
            ),
            minHeight: 8,
          ),
        ],
      ),
    );
  }
}
