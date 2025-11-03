import 'package:hive/hive.dart';

part 'brand_data.g.dart';

@HiveType(typeId: 40)
class ContentIdea extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late ContentPillar pillar;

  @HiveField(4)
  late ContentPlatform platform;

  @HiveField(5)
  late DateTime createdAt;

  @HiveField(6)
  late ContentStatus status;

  @HiveField(7)
  String? caption;

  @HiveField(8)
  List<String>? tags;

  ContentIdea({
    required this.id,
    required this.title,
    required this.description,
    required this.pillar,
    required this.platform,
    required this.createdAt,
    this.status = ContentStatus.idea,
    this.caption,
    this.tags,
  });
}

@HiveType(typeId: 41)
enum ContentPillar {
  @HiveField(0)
  selfImprovement,

  @HiveField(1)
  disciplineFocus,

  @HiveField(2)
  fitnessAesthetics,

  @HiveField(3)
  academicMindset,

  @HiveField(4)
  lifestylePhilosophy,
}

@HiveType(typeId: 42)
enum ContentPlatform {
  @HiveField(0)
  instagram,

  @HiveField(1)
  youtube,

  @HiveField(2)
  twitter,

  @HiveField(3)
  threads,

  @HiveField(4)
  notion,

  @HiveField(5)
  blog,
}

@HiveType(typeId: 43)
enum ContentStatus {
  @HiveField(0)
  idea,

  @HiveField(1)
  planned,

  @HiveField(2)
  inProgress,

  @HiveField(3)
  completed,

  @HiveField(4)
  published,
}

@HiveType(typeId: 44)
class BrandMetrics extends HiveObject {
  @HiveField(0)
  late String date;

  @HiveField(1)
  late int instagramFollowers;

  @HiveField(2)
  late int youtubeSubscribers;

  @HiveField(3)
  late int totalViews;

  @HiveField(4)
  late int engagement;

  @HiveField(5)
  late double revenue;

  BrandMetrics({
    required this.date,
    this.instagramFollowers = 0,
    this.youtubeSubscribers = 0,
    this.totalViews = 0,
    this.engagement = 0,
    this.revenue = 0.0,
  });
}

@HiveType(typeId: 45)
class WeeklyContentSchedule extends HiveObject {
  @HiveField(0)
  late String weekStart; // YYYY-MM-DD

  @HiveField(1)
  late Map<String, ContentTask> schedule;

  WeeklyContentSchedule({
    required this.weekStart,
    Map<String, ContentTask>? schedule,
  }) {
    this.schedule = schedule ?? _defaultSchedule();
  }

  Map<String, ContentTask> _defaultSchedule() {
    return {
      'Monday': ContentTask(day: 'Monday', type: 'Reel', topic: 'Discipline', platform: ContentPlatform.instagram),
      'Wednesday': ContentTask(day: 'Wednesday', type: 'Short', topic: 'Study Tip', platform: ContentPlatform.youtube),
      'Friday': ContentTask(day: 'Friday', type: 'Post', topic: 'Mindset', platform: ContentPlatform.twitter),
      'Sunday': ContentTask(day: 'Sunday', type: 'Reflection', topic: 'Weekly Review', platform: ContentPlatform.notion),
    };
  }
}

@HiveType(typeId: 46)
class ContentTask extends HiveObject {
  @HiveField(0)
  late String day;

  @HiveField(1)
  late String type;

  @HiveField(2)
  late String topic;

  @HiveField(3)
  late ContentPlatform platform;

  @HiveField(4)
  bool completed = false;

  ContentTask({
    required this.day,
    required this.type,
    required this.topic,
    required this.platform,
    this.completed = false,
  });
}
