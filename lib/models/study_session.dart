import 'package:hive/hive.dart';

part 'study_session.g.dart';

@HiveType(typeId: 10)
class StudySession extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String subject;

  @HiveField(2)
  late String topic;

  @HiveField(3)
  late DateTime startTime;

  @HiveField(4)
  DateTime? endTime;

  @HiveField(5)
  late int durationMinutes;

  @HiveField(6)
  late int focusPercentage; // 0-100

  @HiveField(7)
  String? notes;

  @HiveField(8)
  String? mockTestResult;

  @HiveField(9)
  String? reflection;

  @HiveField(10)
  late StudyType type;

  @HiveField(11)
  late bool isCompleted;

  StudySession({
    required this.id,
    required this.subject,
    required this.topic,
    required this.startTime,
    this.endTime,
    this.durationMinutes = 0,
    this.focusPercentage = 100,
    this.notes,
    this.mockTestResult,
    this.reflection,
    this.type = StudyType.deepFocus,
    this.isCompleted = false,
  });

  int get actualDuration {
    if (endTime != null) {
      return endTime!.difference(startTime).inMinutes;
    }
    return durationMinutes;
  }
}

@HiveType(typeId: 11)
enum StudyType {
  @HiveField(0)
  deepFocus,

  @HiveField(1)
  revision,

  @HiveField(2)
  mockTest,

  @HiveField(3)
  practice,

  @HiveField(4)
  constitution,
}

@HiveType(typeId: 12)
class SubjectProgress extends HiveObject {
  @HiveField(0)
  late String subject;

  @HiveField(1)
  late int totalTopics;

  @HiveField(2)
  late int completedTopics;

  @HiveField(3)
  late Map<String, bool> topics; // topic name -> completed

  @HiveField(4)
  late double totalHours;

  @HiveField(5)
  DateTime? lastStudied;

  SubjectProgress({
    required this.subject,
    this.totalTopics = 0,
    this.completedTopics = 0,
    Map<String, bool>? topics,
    this.totalHours = 0.0,
    this.lastStudied,
  }) {
    this.topics = topics ?? {};
  }

  double get progressPercentage {
    if (totalTopics == 0) return 0;
    return (completedTopics / totalTopics) * 100;
  }
}

@HiveType(typeId: 13)
class ConstitutionTracker extends HiveObject {
  @HiveField(0)
  late Map<int, ArticleStatus> articles; // Article number -> status

  @HiveField(1)
  late int totalArticles;

  @HiveField(2)
  late int masteredArticles;

  ConstitutionTracker({
    Map<int, ArticleStatus>? articles,
    this.totalArticles = 51,
    this.masteredArticles = 0,
  }) {
    this.articles = articles ?? _initializeArticles();
  }

  Map<int, ArticleStatus> _initializeArticles() {
    return Map.fromIterable(
      List.generate(51, (i) => i + 1),
      key: (item) => item,
      value: (_) => ArticleStatus.notStarted,
    );
  }

  double get progressPercentage {
    return (masteredArticles / totalArticles) * 100;
  }
}

@HiveType(typeId: 14)
enum ArticleStatus {
  @HiveField(0)
  notStarted,

  @HiveField(1)
  learning,

  @HiveField(2)
  revision,

  @HiveField(3)
  mastered,
}
