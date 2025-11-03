import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import '../providers/theme_provider.dart';
import '../providers/daily_missions_provider.dart';

class DailyMissionsScreen extends ConsumerStatefulWidget {
  const DailyMissionsScreen({super.key});

  @override
  ConsumerState<DailyMissionsScreen> createState() => _DailyMissionsScreenState();
}

class _DailyMissionsScreenState extends ConsumerState<DailyMissionsScreen> {
  void _addMission(String category) {
    final nameController = TextEditingController();
    final targetController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add ${category.toUpperCase()} Mission'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Mission Name',
                hintText: 'e.g., MHCET Math Practice',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: targetController,
              decoration: const InputDecoration(
                labelText: 'Target',
                hintText: 'e.g., 50 questions',
              ),
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
              if (nameController.text.isNotEmpty && targetController.text.isNotEmpty) {
                ref.read(dailyMissionsProvider.notifier).addMission(
                  category,
                  nameController.text,
                  targetController.text,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final missionsNotifier = ref.watch(dailyMissionsProvider.notifier);
    final totalMissions = missionsNotifier.totalMissions;
    final completedMissions = missionsNotifier.completedMissions;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('DAILY MISSIONS'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header
          Text(
            '🎯 Today\'s Mission Control',
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Track and complete your daily targets',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Academics Mission
          _buildMissionCategory(
            'academics',
            '📚 ACADEMICS',
            Icons.school,
            AppTheme.getStudyColor(themeMode),
            themeMode,
          ),

          // Fitness Mission
          _buildMissionCategory(
            'fitness',
            '💪 FITNESS',
            Icons.fitness_center,
            AppTheme.getFitnessColor(themeMode),
            themeMode,
          ),

          // 7K Brand Mission
          _buildMissionCategory(
            'brand',
            '🚀 7K ECOSYSTEM',
            Icons.trending_up,
            AppTheme.getBrandColor(themeMode),
            themeMode,
          ),

          // Confidence Mission
          _buildMissionCategory(
            'confidence',
            '⚡ CONFIDENCE',
            Icons.psychology,
            AppTheme.getConfidenceColor(themeMode),
            themeMode,
          ),

          const SizedBox(height: 24),

          // Overall Progress
          if (totalMissions > 0)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'OVERALL MISSION PROGRESS',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircularProgressIndicator(
                              value: completedMissions / totalMissions,
                              strokeWidth: 12,
                              backgroundColor: Colors.white12,
                              valueColor: AlwaysStoppedAnimation(AppTheme.getStudyColor(themeMode)),
                            ),
                          ),
                          Text(
                            '${((completedMissions / totalMissions) * 100).toInt()}%',
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: AppTheme.getStudyColor(themeMode),
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$completedMissions of $totalMissions missions completed',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMissionCategory(String category, String title, IconData icon, Color color, AppThemeMode themeMode) {
    final missions = ref.watch(dailyMissionsProvider)[category]!;
    final completed = missions.where((m) => m.completed).length;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: Icon(icon, color: color, size: 32),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        subtitle: missions.isEmpty
            ? const Text('Tap + to add missions')
            : Text('$completed/${missions.length} completed'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.add_circle, color: color),
              onPressed: () => _addMission(category),
            ),
            const Icon(Icons.expand_more),
          ],
        ),
        children: [
          if (missions.isEmpty)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(Icons.inbox, size: 48, color: Colors.white24),
                  const SizedBox(height: 12),
                  Text(
                    'No missions yet',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white54,
                        ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () => _addMission(category),
                    icon: const Icon(Icons.add),
                    label: const Text('Add First Mission'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                    ),
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: List.generate(missions.length, (index) {
                  final mission = missions[index];
                  return Dismissible(
                    key: Key('${category}_$index'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) => ref.read(dailyMissionsProvider.notifier).deleteMission(category, index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: mission.completed,
                                onChanged: (_) => ref.read(dailyMissionsProvider.notifier).toggleMission(category, index),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      mission.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        decoration: mission.completed
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      mission.target,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${(mission.progress * 100).toInt()}%',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Slider(
                                  value: mission.progress,
                                  onChanged: (value) => ref.read(dailyMissionsProvider.notifier).updateProgress(category, index, value),
                                  activeColor: color,
                                  inactiveColor: Colors.white12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}
