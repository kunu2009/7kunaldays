import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import '../providers/theme_provider.dart';

class NutritionTrackerScreen extends ConsumerStatefulWidget {
  const NutritionTrackerScreen({super.key});

  @override
  ConsumerState<NutritionTrackerScreen> createState() => _NutritionTrackerScreenState();
}

class _NutritionTrackerScreenState extends ConsumerState<NutritionTrackerScreen> {
  double waterIntake = 0.0; // liters
  
  final List<Map<String, dynamic>> meals = [
    {'time': '7:15 AM', 'meal': 'Breakfast', 'food': 'Milk (1 glass) + Banana + Peanuts (handful) or Yogurt + dry fruits', 'calories': 350, 'logged': false},
    {'time': '12:30 PM', 'meal': 'Lunch', 'food': 'Dal chawal or Roti + Sabzi (home style) + small salad', 'calories': 550, 'logged': false},
    {'time': '5:30 PM', 'meal': 'Evening Snack', 'food': 'Yogurt / Lassi + Salted peanuts / dry fruits', 'calories': 275, 'logged': false},
    {'time': '8:00 PM', 'meal': 'Dinner', 'food': 'Light Dal chawal + Papad / Achar', 'calories': 450, 'logged': false},
  ];

  void _addMeal() {
    final timeController = TextEditingController();
    final mealController = TextEditingController();
    final foodController = TextEditingController();
    final caloriesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Meal'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  hintText: 'e.g., 8:00 AM',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: mealController,
                decoration: const InputDecoration(
                  labelText: 'Meal Name',
                  hintText: 'e.g., Breakfast',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: foodController,
                decoration: const InputDecoration(
                  labelText: 'Food Items',
                  hintText: 'e.g., Oats + Banana',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: caloriesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Calories',
                  hintText: 'e.g., 450',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (timeController.text.isNotEmpty && 
                  mealController.text.isNotEmpty &&
                  foodController.text.isNotEmpty &&
                  caloriesController.text.isNotEmpty) {
                setState(() {
                  meals.add({
                    'time': timeController.text,
                    'meal': mealController.text,
                    'food': foodController.text,
                    'calories': int.tryParse(caloriesController.text) ?? 0,
                    'logged': false,
                  });
                });
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
    final totalCalories = meals.where((m) => m['logged']).fold(0, (sum, m) => sum + (m['calories'] as int));
    final targetCalories = 1650; // 1500-1800 kcal range, using midpoint
    final waterGoal = 2.75; // 2.5-3.0 L range, using midpoint
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('NUTRITION TRACKER'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header Stats
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Calories',
                  value: '$totalCalories/$targetCalories',
                  icon: Icons.local_fire_department,
                  color: AppTheme.getFitnessColor(themeMode),
                  progress: totalCalories / targetCalories,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  title: 'Water',
                  value: '$waterIntake/${waterGoal}L',
                  icon: Icons.water_drop,
                  color: AppTheme.getConfidenceColor(themeMode),
                  progress: waterIntake / waterGoal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Water Tracker
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.water_drop, color: AppTheme.getConfidenceColor(themeMode)),
                      const SizedBox(width: 12),
                      Text(
                        'WATER INTAKE',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      final filled = index < (waterIntake * 2).toInt();
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            waterIntake = (index + 1) * 0.5;
                          });
                        },
                        child: Icon(
                          filled ? Icons.water_drop : Icons.water_drop_outlined,
                          color: filled ? AppTheme.getConfidenceColor(themeMode) : Colors.white30,
                          size: 40,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      '$waterIntake Liters',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppTheme.getConfidenceColor(themeMode),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Meal Plan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '🍽️ MEAL PLAN',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: AppTheme.primaryTeal),
                onPressed: _addMeal,
              ),
            ],
          ),
          const SizedBox(height: 12),

          if (meals.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    Icon(Icons.restaurant, size: 64, color: Colors.white24),
                    const SizedBox(height: 16),
                    Text(
                      'No meals logged yet',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white54,
                          ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _addMeal,
                      icon: const Icon(Icons.add),
                      label: const Text('Log First Meal'),
                    ),
                  ],
                ),
              ),
            )
          else
            ...meals.asMap().entries.map((entry) {
              final index = entry.key;
              final meal = entry.value;
              return Dismissible(
                key: Key('meal_$index'),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) {
                  setState(() {
                    meals.removeAt(index);
                  });
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: meal['logged']
                          ? AppTheme.getFitnessColor(themeMode).withOpacity(0.2)
                          : Colors.white12,
                      child: Icon(
                        meal['logged'] ? Icons.check : Icons.restaurant,
                        color: meal['logged']
                            ? AppTheme.getFitnessColor(themeMode)
                            : Colors.white30,
                      ),
                    ),
                    title: Text(
                      meal['meal'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: meal['logged'] ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${meal['time']} • ${meal['food']}'),
                        const SizedBox(height: 4),
                        Text(
                          '${meal['calories']} cal',
                          style: TextStyle(
                            color: AppTheme.getFitnessColor(themeMode),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: Checkbox(
                      value: meal['logged'],
                      onChanged: (value) {
                        setState(() {
                          meal['logged'] = value ?? false;
                        });
                      },
                    ),
                    isThreeLine: true,
                  ),
                ),
              );
            }).toList(),

          const SizedBox(height: 24),

          // Macros Summary
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MACROS BREAKDOWN',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  _MacroBar(
                    label: 'Protein',
                    value: 180,
                    target: 200,
                    color: AppTheme.getFitnessColor(themeMode),
                  ),
                  const SizedBox(height: 12),
                  _MacroBar(
                    label: 'Carbs',
                    value: 220,
                    target: 300,
                    color: AppTheme.getBrandColor(themeMode),
                  ),
                  const SizedBox(height: 12),
                  _MacroBar(
                    label: 'Fats',
                    value: 50,
                    target: 70,
                    color: AppTheme.getStudyColor(themeMode),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addMeal,
        icon: const Icon(Icons.add),
        label: const Text('Log Meal'),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final double progress;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: color,
                    fontSize: 16,
                  ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress > 1.0 ? 1.0 : progress,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _MacroBar extends StatelessWidget {
  final String label;
  final int value;
  final int target;
  final Color color;

  const _MacroBar({
    required this.label,
    required this.value,
    required this.target,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final progress = value / target;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '$value/$target g',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress > 1.0 ? 1.0 : progress,
          backgroundColor: Colors.white12,
          valueColor: AlwaysStoppedAnimation(color),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
