import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/daily_log_provider.dart';
import '../providers/today_missions_provider.dart';
import '../core/theme.dart';
import '../services/ai_companion.dart';
import 'dashboard_screen.dart';
import 'study_command_center.dart';
import 'fitness_command_center.dart';
import 'confidence_lab.dart';
import 'brand_hub.dart';
import 'settings_screen.dart';
import 'daily_missions_screen.dart';
import 'nutrition_tracker_screen.dart';
import 'planner_timeline_screen.dart';
import '../widgets/daily_section_card.dart';
import '../widgets/quick_metrics_card.dart';
import '../widgets/reflection_card.dart';
import '../widgets/todo_remember_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const TodayLogScreen(),
    const DashboardScreen(),
    const StudyCommandCenter(),
    const FitnessCommandCenter(),
    const ConfidenceLab(),
    const BrandHub(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Study',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Fitness',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'Confidence',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium),
            label: '7K',
          ),
        ],
      ),
    );
  }
}

class TodayLogScreen extends ConsumerWidget {
  const TodayLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayLog = ref.watch(todayLogProvider);
    final now = DateTime.now();
    final dateStr = DateFormat('EEEE, MMMM d, yyyy').format(now);

    return Scaffold(
      appBar: AppBar(
        title: const Text('KUNAL\'S EVOLUTION OS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(todayLogProvider.notifier).refresh();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // AI Greeting Header
            _buildAIGreetingCard(context, todayLog),
            const SizedBox(height: 20),

            // Date Header
            _buildHeader(context, dateStr, todayLog),
            const SizedBox(height: 20),

            // CURRENT TIME BLOCK TASK (Priority Display)
            _buildCurrentTimeBlockTask(context, ref, todayLog),
            const SizedBox(height: 24),

            // TODO / Remember Widget
            const TodoRememberCard(),
            const SizedBox(height: 24),

            // Quick Start Command Centers (Expanded)
            _buildExpandedCommandCenters(context),
            const SizedBox(height: 24),

            // Today's Missions
            _buildTodayMissions(context, ref),
            const SizedBox(height: 24),

            // Quick Metrics
            QuickMetricsCard(log: todayLog),
            const SizedBox(height: 20),

            // Quick Actions
            _buildQuickActions(context, ref),
            const SizedBox(height: 24),

            // Daily Sections
            DailySectionCard(
              title: '🌅 MORNING (6:00 – 10:45 AM)',
              subtitle: 'Preparation, movement, and first study sprint',
              checklist: todayLog.morningChecklist,
              onToggle: (task) {
                ref.read(todayLogProvider.notifier).toggleMorningTask(task);
              },
              reflectionValue: todayLog.morningWins,
              onReflectionChanged: (value) {
                ref.read(todayLogProvider.notifier)
                    .updateReflection('morningWins', value);
              },
              reflectionLabel: '📝 Morning Wins',
              color: AppTheme.studyColor,
            ),
            const SizedBox(height: 16),

            DailySectionCard(
              title: '🏫 COLLEGE (11:55 AM – 6 PM)',
              subtitle: 'Focus in lectures, productive free periods',
              checklist: todayLog.collegeChecklist,
              onToggle: (task) {
                ref.read(todayLogProvider.notifier).toggleCollegeTask(task);
              },
              reflectionValue: todayLog.collegeInteractions,
              onReflectionChanged: (value) {
                ref.read(todayLogProvider.notifier)
                    .updateReflection('collegeInteractions', value);
              },
              reflectionLabel: '💬 Interactions / Observations',
              color: AppTheme.brandColor,
            ),
            const SizedBox(height: 16),

            DailySectionCard(
              title: '🌇 EVENING (6:30 – 10:30 PM)',
              subtitle: '7K work, Study Block 2, Quality time',
              checklist: todayLog.eveningChecklist,
              onToggle: (task) {
                ref.read(todayLogProvider.notifier).toggleEveningTask(task);
              },
              reflectionValue: todayLog.eveningIdeas,
              onReflectionChanged: (value) {
                ref.read(todayLogProvider.notifier)
                    .updateReflection('eveningIdeas', value);
              },
              reflectionLabel: '💡 Ideas / Learning from 7K work',
              color: AppTheme.fitnessColor,
            ),
            const SizedBox(height: 16),

            DailySectionCard(
              title: '🌙 NIGHT (10:30 PM – 1 AM)',
              subtitle: 'Calm study, dinner, sleep setup',
              checklist: todayLog.nightChecklist,
              onToggle: (task) {
                ref.read(todayLogProvider.notifier).toggleNightTask(task);
              },
              color: AppTheme.confidenceColor,
            ),
            const SizedBox(height: 24),

            // Reflections
            ReflectionCard(log: todayLog),
            const SizedBox(height: 24),

            // Night Affirmation
            _buildNightAffirmation(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAIGreetingCard(BuildContext context, log) {
    final greeting = AICompanion.getGreeting();
    final timeBlock = AICompanion.getTimeBlockSuggestion();
    
    return Card(
      color: AppTheme.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppTheme.primaryTeal,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.access_time, color: AppTheme.brandColor, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    timeBlock,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentTimeBlockTask(BuildContext context, WidgetRef ref, log) {
    final hour = DateTime.now().hour;
    String blockTitle;
    Map<String, bool> blockChecklist;
    String blockTime;
    Color blockColor;
    Function(String) toggleFunction;
    String timeBlockKey;

    if (hour >= 6 && hour < 11) {
      blockTitle = '🌅 MORNING PRIORITY';
      blockTime = '6:00 - 10:45 AM';
      blockChecklist = log.morningChecklist;
      blockColor = AppTheme.studyColor;
      toggleFunction = (task) => ref.read(todayLogProvider.notifier).toggleMorningTask(task);
      timeBlockKey = 'morning';
    } else if (hour >= 11 && hour < 18) {
      blockTitle = '🏫 COLLEGE FOCUS';
      blockTime = '11:55 AM - 6:00 PM';
      blockChecklist = log.collegeChecklist;
      blockColor = AppTheme.brandColor;
      toggleFunction = (task) => ref.read(todayLogProvider.notifier).toggleCollegeTask(task);
      timeBlockKey = 'college';
    } else if (hour >= 18 && hour < 22) {
      blockTitle = '🌇 EVENING EXECUTION';
      blockTime = '6:30 - 10:30 PM';
      blockChecklist = log.eveningChecklist;
      blockColor = AppTheme.fitnessColor;
      toggleFunction = (task) => ref.read(todayLogProvider.notifier).toggleEveningTask(task);
      timeBlockKey = 'evening';
    } else {
      blockTitle = '🌙 NIGHT CLOSURE';
      blockTime = '10:30 PM - 1:00 AM';
      blockChecklist = log.nightChecklist;
      blockColor = AppTheme.confidenceColor;
      toggleFunction = (task) => ref.read(todayLogProvider.notifier).toggleNightTask(task);
      timeBlockKey = 'night';
    }

    final completed = blockChecklist.values.where((v) => v).length;
    final total = blockChecklist.length;

    return Card(
      color: blockColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: blockColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blockTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: blockColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      blockTime,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: blockColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$completed/$total',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: blockColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle, color: blockColor),
                      onPressed: () => _showAddTaskDialog(context, ref, timeBlockKey, blockColor),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...blockChecklist.entries.map((entry) => Dismissible(
                  key: Key('${timeBlockKey}_${entry.key}'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    ref.read(todayLogProvider.notifier).removeTask(timeBlockKey, entry.key);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: () => toggleFunction(entry.key),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        decoration: BoxDecoration(
                          color: entry.value 
                              ? blockColor.withOpacity(0.2) 
                              : AppTheme.darkBackground,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: entry.value ? blockColor : Colors.white24,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              entry.value ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: entry.value ? blockColor : Colors.white54,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                entry.key,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: entry.value ? Colors.white : Colors.white70,
                                  decoration: entry.value ? TextDecoration.lineThrough : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: total > 0 ? completed / total : 0,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation(blockColor),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref, String timeBlock, Color color) {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Task to ${timeBlock.toUpperCase()}'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Task Name',
            hintText: 'e.g., Review notes',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref.read(todayLogProvider.notifier).addTask(timeBlock, controller.text);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: color),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedCommandCenters(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🎯 Quick Access',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            // Primary Command Centers
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _buildCommandButton(
                  context,
                  '📚\nStudy',
                  AppTheme.studyColor,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudyCommandCenter())),
                ),
                _buildCommandButton(
                  context,
                  '💪\nFitness',
                  AppTheme.fitnessColor,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FitnessCommandCenter())),
                ),
                _buildCommandButton(
                  context,
                  '💬\nConfidence',
                  AppTheme.confidenceColor,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ConfidenceLab())),
                ),
                _buildCommandButton(
                  context,
                  '🎬\n7K Brand',
                  AppTheme.brandColor,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BrandHub())),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.white24),
            const SizedBox(height: 12),
            // Dashboard Quick Actions
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _buildSmallCommandButton(
                  context,
                  '🎯\nDaily\nMissions',
                  AppTheme.fitnessColor,
                  Icons.flag,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DailyMissionsScreen())),
                ),
                _buildSmallCommandButton(
                  context,
                  '🍎\nNutrition',
                  AppTheme.brandColor,
                  Icons.restaurant_menu,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NutritionTrackerScreen())),
                ),
                _buildSmallCommandButton(
                  context,
                  '⏱️\nTimeline',
                  AppTheme.studyColor,
                  Icons.access_time,
                  () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlannerTimelineScreen())),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommandButton(BuildContext context, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSmallCommandButton(BuildContext context, String label, Color color, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(
              label.split('\n').last,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayMissions(BuildContext context, WidgetRef ref) {
    final missions = ref.watch(todayMissionsProvider);
    final completed = missions.values.where((v) => v).length;
    final total = missions.length;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.task_alt, color: AppTheme.primaryTeal),
                const SizedBox(width: 12),
                Text(
                  'Today\'s Missions',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryTeal.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.primaryTeal),
                  ),
                  child: Text(
                    '$completed/$total',
                    style: const TextStyle(
                      color: AppTheme.primaryTeal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (total > 0)
              LinearProgressIndicator(
                value: completed / total,
                backgroundColor: Colors.white12,
                valueColor: const AlwaysStoppedAnimation(AppTheme.primaryTeal),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
            const SizedBox(height: 16),
            ...missions.entries.map((entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () => ref.read(todayMissionsProvider.notifier).toggleMission(entry.key),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                        color: entry.value 
                            ? AppTheme.primaryTeal.withOpacity(0.2) 
                            : AppTheme.darkBackground,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: entry.value ? AppTheme.primaryTeal : Colors.white24,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            entry.value ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: entry.value ? AppTheme.primaryTeal : Colors.white38,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              entry.key,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    decoration: entry.value
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: entry.value ? Colors.white38 : Colors.white70,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String dateStr, log) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dateStr,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Mood: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  log.mood,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 24),
                Text(
                  'Sleep: ${log.sleepHours.toStringAsFixed(1)} hrs',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Theme: ${log.theme}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.primaryTeal,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: log.completionPercentage / 100,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation(AppTheme.primaryTeal),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Text(
              '${log.completionPercentage.toStringAsFixed(0)}% Complete',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              ref.read(todayLogProvider.notifier).copyFromYesterday();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✅ Copied unfinished tasks from yesterday'),
                ),
              );
            },
            icon: const Icon(Icons.copy),
            label: const Text('Copy Yesterday'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.cardBackground,
              foregroundColor: AppTheme.primaryTeal,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement export
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('📄 Export coming soon...'),
                ),
              );
            },
            icon: const Icon(Icons.file_download),
            label: const Text('Export'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.cardBackground,
              foregroundColor: AppTheme.primaryTeal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNightAffirmation() {
    return Card(
      color: AppTheme.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.nights_stay,
              color: AppTheme.primaryTeal,
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              '"Tomorrow, I rise 1% better — quietly, relentlessly."',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
