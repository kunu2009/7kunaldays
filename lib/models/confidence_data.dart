import 'package:hive/hive.dart';

part 'confidence_data.g.dart';

@HiveType(typeId: 30)
class ConfidenceSession extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late DateTime timestamp;

  @HiveField(2)
  late ConfidenceType type;

  @HiveField(3)
  late int durationMinutes;

  @HiveField(4)
  String? recordingPath;

  @HiveField(5)
  String? notes;

  @HiveField(6)
  late int selfRating; // 1-10

  @HiveField(7)
  late bool completed;

  ConfidenceSession({
    required this.id,
    required this.timestamp,
    required this.type,
    this.durationMinutes = 0,
    this.recordingPath,
    this.notes,
    this.selfRating = 5,
    this.completed = false,
  });
}

@HiveType(typeId: 31)
enum ConfidenceType {
  @HiveField(0)
  mirrorTalk,

  @HiveField(1)
  readingAloud,

  @HiveField(2)
  postureCheck,

  @HiveField(3)
  socialWarmup,

  @HiveField(4)
  publicSpeaking,
}

@HiveType(typeId: 32)
class CharismaChallenge extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late String date;

  @HiveField(4)
  late bool completed;

  @HiveField(5)
  String? reflection;

  CharismaChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.completed = false,
    this.reflection,
  });

  static List<CharismaChallenge> getWeeklyChallenges(String startDate) {
    return [
      CharismaChallenge(
        id: 'ch_1',
        title: 'Eye Contact Master',
        description: 'Maintain eye contact in 3 conversations today',
        date: startDate,
      ),
      CharismaChallenge(
        id: 'ch_2',
        title: 'Slow & Deliberate Speech',
        description: 'Speak 30% slower in all interactions',
        date: startDate,
      ),
      CharismaChallenge(
        id: 'ch_3',
        title: 'Posture Power Hour',
        description: 'Maintain perfect posture for 1 hour straight',
        date: startDate,
      ),
      CharismaChallenge(
        id: 'ch_4',
        title: 'Confident Introduction',
        description: 'Introduce yourself confidently to someone new',
        date: startDate,
      ),
      CharismaChallenge(
        id: 'ch_5',
        title: 'Active Listening',
        description: 'Practice active listening in 2 conversations',
        date: startDate,
      ),
    ];
  }
}

@HiveType(typeId: 33)
class GroomingRoutine extends HiveObject {
  @HiveField(0)
  late String date;

  @HiveField(1)
  late Map<String, bool> tasks;

  GroomingRoutine({
    required this.date,
    Map<String, bool>? tasks,
  }) {
    this.tasks = tasks ?? _defaultTasks();
  }

  Map<String, bool> _defaultTasks() {
    return {
      'Skincare routine': false,
      'Clean clothes': false,
      'Tidy hairstyle': false,
      'Fresh breath check': false,
      'Nails trimmed': false,
    };
  }

  double get completionPercentage {
    if (tasks.isEmpty) return 0;
    int completed = tasks.values.where((v) => v).length;
    return (completed / tasks.length) * 100;
  }
}
