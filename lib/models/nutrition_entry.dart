import 'package:hive/hive.dart';

part 'nutrition_entry.g.dart';

@HiveType(typeId: 4)
class NutritionEntry extends HiveObject {
  @HiveField(0)
  late String time;

  @HiveField(1)
  late String food;

  @HiveField(2)
  String? notes;

  NutritionEntry({
    required this.time,
    required this.food,
    this.notes,
  });

  // Predefined meal plan based on template
  static List<NutritionEntry> getDefaultMealPlan() {
    return [
      NutritionEntry(
        time: '10:30 AM',
        food: 'Vadapav/Samosa + Banana',
        notes: 'Breakfast',
      ),
      NutritionEntry(
        time: '8:00 PM',
        food: 'Chai + Snack',
        notes: 'Evening',
      ),
      NutritionEntry(
        time: '12:00 AM',
        food: '2 Chapati + Dal + Sabzi',
        notes: 'Dinner',
      ),
    ];
  }
}
