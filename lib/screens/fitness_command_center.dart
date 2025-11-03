import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../core/theme.dart';

class FitnessCommandCenter extends ConsumerStatefulWidget {
  const FitnessCommandCenter({super.key});

  @override
  ConsumerState<FitnessCommandCenter> createState() => _FitnessCommandCenterState();
}

class _FitnessCommandCenterState extends ConsumerState<FitnessCommandCenter> {
  final Map<String, bool> _todayWorkout = {
    'Jumping Jacks × 3 sets × 50': false,
    'Pushups × 3 sets × 15': false,
    'Bodyweight Squats × 3 sets × 20': false,
    'Hanging / Wall Stretch × 3 × 1 min': false,
    'Cobra Stretch × 3 × 30 sec': false,
    'Plank × 3 × 45 sec': false,
  };

  double _currentHeight = 5.42; // 5'5" = 5.4167 ft
  double _currentWeight = 49.9; // kg
  int _workoutStreak = 18;
  int _energyLevel = 7;

  final List<Map<String, dynamic>> _weeklyEnergy = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💪 FITNESS COMMAND CENTER'),
        actions: [
          IconButton(
            icon: const Icon(Icons.insights),
            onPressed: () {
              // Show fitness insights
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Stats Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          '📏 Height',
                          '${_currentHeight.toStringAsFixed(1)} ft',
                          'Goal: 6.3 ft',
                          AppTheme.studyColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatItem(
                          '⚖️ Weight',
                          '${_currentWeight.toStringAsFixed(1)} kg',
                          'Target: 66 kg',
                          AppTheme.fitnessColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          '🔥 Streak',
                          '$_workoutStreak days',
                          'Keep going!',
                          AppTheme.brandColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatItem(
                          '⚡ Energy',
                          '$_energyLevel/10',
                          'Feeling strong',
                          AppTheme.confidenceColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Morning Routine
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🌅 Today\'s Morning Routine',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Daily foundation for growth',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  ..._todayWorkout.entries.map((entry) => CheckboxListTile(
                        title: Text(entry.key),
                        value: entry.value,
                        onChanged: (value) {
                          setState(() {
                            _todayWorkout[entry.key] = value ?? false;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                      )),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: _todayWorkout.values.where((v) => v).length / _todayWorkout.length,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation(AppTheme.fitnessColor),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_todayWorkout.values.where((v) => v).length}/${_todayWorkout.length} completed',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Energy Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '⚡ Weekly Energy Levels',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  if (_weeklyEnergy.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.battery_unknown, size: 48, color: Colors.white24),
                            const SizedBox(height: 12),
                            Text(
                              'No energy data yet',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white54,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Log your daily energy level to see trends',
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 10,
                          barTouchData: BarTouchData(enabled: false),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  if (value.toInt() >= 0 && value.toInt() < _weeklyEnergy.length) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        _weeklyEnergy[value.toInt()]['day'],
                                        style: const TextStyle(fontSize: 12, color: Colors.white70),
                                      ),
                                    );
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                                  );
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 2,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.white10,
                                strokeWidth: 1,
                              );
                            },
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: _weeklyEnergy.asMap().entries.map((entry) {
                            return BarChartGroupData(
                              x: entry.key,
                              barRods: [
                                BarChartRodData(
                                  toY: entry.value['energy'].toDouble(),
                                  color: AppTheme.fitnessColor,
                                  width: 20,
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Budget Meal Plan
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🍽️ Budget-Friendly Meal Plan',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  _buildMealSection('Breakfast', ['Milk', 'Peanuts', 'Banana']),
                  const SizedBox(height: 12),
                  _buildMealSection('Lunch', ['Dal-chawal', 'Roti-sabzi']),
                  const SizedBox(height: 12),
                  _buildMealSection('Evening', ['Yogurt/Lassi', 'Dry fruits']),
                  const SizedBox(height: 12),
                  _buildMealSection('Dinner', ['Light dal-chawal', 'Papad/Achar']),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // AI Suggestions
          Card(
            color: AppTheme.cardBackground,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.psychology, color: AppTheme.primaryTeal),
                      const SizedBox(width: 12),
                      Text(
                        'AI Fitness Coach',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _getAISuggestion(),
                    style: Theme.of(context).textTheme.bodyMedium,
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
                    // Log measurement
                    _showMeasurementDialog();
                  },
                  icon: const Icon(Icons.straighten),
                  label: const Text('Log Stats'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.fitnessColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // View history
                  },
                  icon: const Icon(Icons.history),
                  label: const Text('History'),
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

  Widget _buildStatItem(String title, String value, String subtitle, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }

  Widget _buildMealSection(String mealTime, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mealTime,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppTheme.brandColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          items.join(', '),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  String _getAISuggestion() {
    final completedToday = _todayWorkout.values.where((v) => v).length;
    
    if (completedToday == _todayWorkout.length) {
      return '🎯 Perfect routine completion! Maintain this consistency for aesthetic gains. Consider adding pull-ups to your routine.';
    } else if (completedToday >= 3) {
      return '💪 Good progress today. Complete remaining exercises for full benefits. Your streak depends on it!';
    } else {
      return '⚡ Energy detected: $_energyLevel/10. Start with light skipping to warm up. Build momentum with each rep.';
    }
  }

  void _showMeasurementDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('📊 Log Measurements'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Height (ft)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final parsed = double.tryParse(value);
                if (parsed != null) {
                  setState(() => _currentHeight = parsed);
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final parsed = double.tryParse(value);
                if (parsed != null) {
                  setState(() => _currentWeight = parsed);
                }
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
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ Measurements saved!')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
