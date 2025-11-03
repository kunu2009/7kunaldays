import 'package:hive/hive.dart';

part 'fitness_data.g.dart';

@HiveType(typeId: 20)
class FitnessLog extends HiveObject {
  @HiveField(0)
  late String date; // YYYY-MM-DD

  @HiveField(1)
  late List<Exercise> exercises;

  @HiveField(2)
  late int totalMinutes;

  @HiveField(3)
  late int energyLevel; // 1-10

  @HiveField(4)
  String? notes;

  @HiveField(5)
  late bool workoutCompleted;

  @HiveField(6)
  late double? weight;

  @HiveField(7)
  late double? height; // in cm

  @HiveField(8)
  late BodyMeasurements? measurements;

  FitnessLog({
    required this.date,
    List<Exercise>? exercises,
    this.totalMinutes = 0,
    this.energyLevel = 5,
    this.notes,
    this.workoutCompleted = false,
    this.weight,
    this.height,
    this.measurements,
  }) {
    this.exercises = exercises ?? [];
  }
}

@HiveType(typeId: 21)
class Exercise extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late ExerciseType type;

  @HiveField(2)
  late int sets;

  @HiveField(3)
  late int reps;

  @HiveField(4)
  late int durationMinutes;

  @HiveField(5)
  late bool completed;

  Exercise({
    required this.name,
    required this.type,
    this.sets = 0,
    this.reps = 0,
    this.durationMinutes = 0,
    this.completed = false,
  });
}

@HiveType(typeId: 22)
enum ExerciseType {
  @HiveField(0)
  cardio,

  @HiveField(1)
  strength,

  @HiveField(2)
  flexibility,

  @HiveField(3)
  calisthenics,

  @HiveField(4)
  stretching,
}

@HiveType(typeId: 23)
class BodyMeasurements extends HiveObject {
  @HiveField(0)
  late String date;

  @HiveField(1)
  double? chest;

  @HiveField(2)
  double? waist;

  @HiveField(3)
  double? arms;

  @HiveField(4)
  double? shoulders;

  @HiveField(5)
  double? forearms;

  BodyMeasurements({
    required this.date,
    this.chest,
    this.waist,
    this.arms,
    this.shoulders,
    this.forearms,
  });
}

@HiveType(typeId: 24)
class MealPlan extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late List<String> breakfast;

  @HiveField(2)
  late List<String> lunch;

  @HiveField(3)
  late List<String> evening;

  @HiveField(4)
  late List<String> dinner;

  @HiveField(5)
  late bool isBudgetFriendly;

  MealPlan({
    required this.name,
    List<String>? breakfast,
    List<String>? lunch,
    List<String>? evening,
    List<String>? dinner,
    this.isBudgetFriendly = true,
  }) {
    this.breakfast = breakfast ?? [];
    this.lunch = lunch ?? [];
    this.evening = evening ?? [];
    this.dinner = dinner ?? [];
  }

  static MealPlan getDefaultPlan() {
    return MealPlan(
      name: "Kunal's Budget Plan",
      breakfast: ['Milk', 'Peanuts', 'Banana'],
      lunch: ['Dal-chawal', 'Roti-sabzi'],
      evening: ['Yogurt/Lassi', 'Dry fruits'],
      dinner: ['Light dal-chawal', 'Papad/Achar'],
      isBudgetFriendly: true,
    );
  }
}
