import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/daily_log_provider.dart';
import '../core/theme.dart';
import 'daily_missions_screen.dart';
import 'nutrition_tracker_screen.dart';
import 'planner_timeline_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studyStreak = ref.watch(studyStreakProvider);
    final fitnessStreak = ref.watch(fitnessStreakProvider);
    final journalStreak = ref.watch(journalStreakProvider);
    final weeklyLogs = ref.watch(weeklyLogsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PERFORMANCE DASHBOARD'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Streaks
          Row(
            children: [
              Expanded(
                child: _StreakCard(
                  title: 'Study',
                  streak: studyStreak,
                  icon: Icons.school,
                  color: AppTheme.studyColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StreakCard(
                  title: 'Fitness',
                  streak: fitnessStreak,
                  icon: Icons.fitness_center,
                  color: AppTheme.fitnessColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StreakCard(
                  title: 'Journal',
                  streak: journalStreak,
                  icon: Icons.edit_note,
                  color: AppTheme.confidenceColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Study Hours Chart
          _ChartCard(
            title: '📚 STUDY HOURS (Last 7 Days)',
            child: _buildStudyChart(weeklyLogs),
          ),
          const SizedBox(height: 16),

          // Fitness Minutes Chart
          _ChartCard(
            title: '💪 FITNESS MINUTES (Last 7 Days)',
            child: _buildFitnessChart(weeklyLogs),
          ),
          const SizedBox(height: 16),

          // Sleep Trend
          _ChartCard(
            title: '😴 SLEEP HOURS (Last 7 Days)',
            child: _buildSleepChart(weeklyLogs),
          ),
          const SizedBox(height: 16),

          // Mental Performance Average
          _buildMentalPerformance(weeklyLogs),
          
          const SizedBox(height: 24),
          
          // Quick Access to New Features
          Text(
            '🚀 QUICK ACCESS',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: _QuickAccessCard(
                  title: 'Daily Missions',
                  icon: Icons.flag,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DailyMissionsScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickAccessCard(
                  title: 'Nutrition',
                  icon: Icons.restaurant_menu,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NutritionTrackerScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _QuickAccessCard(
                  title: 'Timeline',
                  icon: Icons.access_time,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PlannerTimelineScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickAccessCard(
                  title: 'Export Data',
                  icon: Icons.file_download,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('📄 Export coming soon...')),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStudyChart(List logs) {
    if (logs.isEmpty) return _emptyChart();

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 30),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(logs.length, (index) {
                return FlSpot(
                  index.toDouble(),
                  logs[index].metrics.studyHours,
                );
              }),
              isCurved: true,
              color: AppTheme.studyColor,
              barWidth: 3,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: AppTheme.studyColor.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFitnessChart(List logs) {
    if (logs.isEmpty) return _emptyChart();

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 30),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(logs.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: logs[index].metrics.fitnessMinutes.toDouble(),
                  color: AppTheme.fitnessColor,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSleepChart(List logs) {
    if (logs.isEmpty) return _emptyChart();

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 30),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(logs.length, (index) {
                return FlSpot(
                  index.toDouble(),
                  logs[index].sleepHours,
                );
              }),
              isCurved: true,
              color: AppTheme.brandColor,
              barWidth: 3,
              dotData: FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMentalPerformance(List logs) {
    if (logs.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text('No data yet'),
        ),
      );
    }

    double avgFocus = 0, avgEnergy = 0, avgMood = 0, avgConfidence = 0, avgControl = 0;
    
    for (var log in logs) {
      avgFocus += log.mentalRatings.focus;
      avgEnergy += log.mentalRatings.energy;
      avgMood += log.mentalRatings.mood;
      avgConfidence += log.mentalRatings.confidence;
      avgControl += log.mentalRatings.selfControl;
    }

    final count = logs.length;
    avgFocus /= count;
    avgEnergy /= count;
    avgMood /= count;
    avgConfidence /= count;
    avgControl /= count;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🧩 AVERAGE MENTAL PERFORMANCE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryTeal,
              ),
            ),
            const SizedBox(height: 20),
            _PerformanceBar('Focus', avgFocus),
            _PerformanceBar('Energy', avgEnergy),
            _PerformanceBar('Mood', avgMood),
            _PerformanceBar('Confidence', avgConfidence),
            _PerformanceBar('Self-Control', avgControl),
          ],
        ),
      ),
    );
  }

  Widget _emptyChart() {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Text(
        'No data yet',
        style: TextStyle(color: Colors.white38),
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  final String title;
  final int streak;
  final IconData icon;
  final Color color;

  const _StreakCard({
    required this.title,
    required this.streak,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              '🔥 $streak',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _ChartCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _PerformanceBar extends StatelessWidget {
  final String label;
  final double value;

  const _PerformanceBar(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text(
                value.toStringAsFixed(1),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryTeal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: value / 10,
            backgroundColor: Colors.white12,
            valueColor: AlwaysStoppedAnimation(AppTheme.primaryTeal),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(icon, size: 32, color: AppTheme.primaryTeal),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
