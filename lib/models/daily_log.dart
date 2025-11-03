import 'package:hive/hive.dart';
import 'nutrition_entry.dart';

part 'daily_log.g.dart';

@HiveType(typeId: 0)
class DailyLog extends HiveObject {
  @HiveField(0)
  late String date; // YYYY-MM-DD format

  @HiveField(1)
  late String mood;

  @HiveField(2)
  late double sleepHours;

  @HiveField(3)
  late String theme; // Focus / Consistency / Growth

  // Checklists for each section
  @HiveField(4)
  late Map<String, bool> morningChecklist;

  @HiveField(5)
  late Map<String, bool> collegeChecklist;

  @HiveField(6)
  late Map<String, bool> eveningChecklist;

  @HiveField(7)
  late Map<String, bool> nightChecklist;

  // Reflections
  @HiveField(8)
  String? morningWins;

  @HiveField(9)
  String? collegeInteractions;

  @HiveField(10)
  String? eveningIdeas;

  @HiveField(11)
  String? oneGreatThing;

  @HiveField(12)
  String? oneImprovement;

  @HiveField(13)
  String? gratitude;

  @HiveField(14)
  List<String>? topThreeWins;

  @HiveField(15)
  String? whatSlowedDown;

  @HiveField(16)
  String? howToImprove;

  @HiveField(17)
  String? lessonOfTheDay;

  @HiveField(18)
  String? thoughtsAndIdeas;

  // Metrics
  @HiveField(19)
  late Metrics metrics;

  // Mental Performance
  @HiveField(20)
  late MentalRatings mentalRatings;

  // 7K Actions
  @HiveField(21)
  List<SevenKAction> sevenKActions = [];

  // Constitution Progress
  @HiveField(22)
  int constitutionProgress = 10; // 0-51

  // Nutrition
  @HiveField(23)
  List<NutritionEntry> nutritionLog = [];

  @HiveField(24)
  double waterIntake = 1.5; // in liters

  // Night Closure
  @HiveField(25)
  String? timeslept;

  @HiveField(26)
  bool phoneUseAfter11PM = false;

  @HiveField(27)
  bool journalDone = false;

  @HiveField(28)
  bool nextDayPrioritySet = false;

  @HiveField(29)
  bool exported = false;

  DailyLog({
    required this.date,
    this.mood = '🧠',
    this.sleepHours = 7.0,
    this.theme = 'Focus',
    Map<String, bool>? morningChecklist,
    Map<String, bool>? collegeChecklist,
    Map<String, bool>? eveningChecklist,
    Map<String, bool>? nightChecklist,
    Metrics? metrics,
    MentalRatings? mentalRatings,
  }) {
    this.morningChecklist = morningChecklist ?? _defaultMorningChecklist();
    this.collegeChecklist = collegeChecklist ?? _defaultCollegeChecklist();
    this.eveningChecklist = eveningChecklist ?? _defaultEveningChecklist();
    this.nightChecklist = nightChecklist ?? _defaultNightChecklist();
    this.metrics = metrics ?? Metrics();
    this.mentalRatings = mentalRatings ?? MentalRatings();
    this.topThreeWins = [];
  }

  static Map<String, bool> _defaultMorningChecklist() {
    return {
      'Wake up + water + quick wash': true,
      'Morning workout (Jumping Jacks/Pushups/Squats/Hanging/Plank)': false,
      'Bath + hygiene': false,
      'Deep Study Block 1 – History (120 min)': false,
      'Deep Study Block 2 – Constitution/Legal Aptitude (120 min)': false,
    };
  }

  static Map<String, bool> _defaultCollegeChecklist() {
    return {
      'Attend all lectures with focus': false,
      'Use 1 free period productively': false,
      'Review notes during travel': false,
    };
  }

  static Map<String, bool> _defaultEveningChecklist() {
    return {
      'Practice / Revision Block (Economics/English/Hindi/Sanskrit)': false,
      'Brand work / Content creation (7K)': false,
      'Light reading / Review + Reflection + Journal': false,
    };
  }

  static Map<String, bool> _defaultNightChecklist() {
    return {
      'Complete all daily missions': false,
      'Mirror talk / Charisma challenge': false,
      'Sleep by 10:45 PM': false,
    };
  }

  // Calculate completion percentage
  double get completionPercentage {
    int total = morningChecklist.length +
        collegeChecklist.length +
        eveningChecklist.length +
        nightChecklist.length;
    int completed = morningChecklist.values.where((v) => v).length +
        collegeChecklist.values.where((v) => v).length +
        eveningChecklist.values.where((v) => v).length +
        nightChecklist.values.where((v) => v).length;
    return total > 0 ? (completed / total) * 100 : 0;
  }
}

@HiveType(typeId: 1)
class Metrics extends HiveObject {
  @HiveField(0)
  double studyHours = 4.0;

  @HiveField(1)
  int fitnessMinutes = 30;

  @HiveField(2)
  double screenTime = 0.0;

  @HiveField(3)
  int steps = 0;

  @HiveField(4)
  double? weight;

  Metrics({
    this.studyHours = 4.0,
    this.fitnessMinutes = 30,
    this.screenTime = 0.0,
    this.steps = 0,
    this.weight,
  });
}

@HiveType(typeId: 2)
class MentalRatings extends HiveObject {
  @HiveField(0)
  int focus = 7;

  @HiveField(1)
  int energy = 7;

  @HiveField(2)
  int mood = 7;

  @HiveField(3)
  int confidence = 7;

  @HiveField(4)
  int selfControl = 7;

  MentalRatings({
    this.focus = 7,
    this.energy = 7,
    this.mood = 7,
    this.confidence = 7,
    this.selfControl = 7,
  });

  double get average {
    return (focus + energy + mood + confidence + selfControl) / 5;
  }
}

@HiveType(typeId: 3)
class SevenKAction extends HiveObject {
  @HiveField(0)
  late String action;

  @HiveField(1)
  late DateTime timestamp;

  SevenKAction({
    required this.action,
    DateTime? timestamp,
  }) {
    this.timestamp = timestamp ?? DateTime.now();
  }
}
