import 'package:hive/hive.dart';

part 'gamification_data.g.dart';

@HiveType(typeId: 50)
class UserProgress extends HiveObject {
  @HiveField(0)
  late int totalXP;

  @HiveField(1)
  late int level;

  @HiveField(2)
  late Map<Pillar, PillarProgress> pillarProgress;

  @HiveField(3)
  late List<Achievement> achievements;

  @HiveField(4)
  late Map<String, int> streaks;

  UserProgress({
    this.totalXP = 0,
    this.level = 1,
    Map<Pillar, PillarProgress>? pillarProgress,
    List<Achievement>? achievements,
    Map<String, int>? streaks,
  }) {
    this.pillarProgress = pillarProgress ?? _initializePillars();
    this.achievements = achievements ?? [];
    this.streaks = streaks ?? {};
  }

  Map<Pillar, PillarProgress> _initializePillars() {
    return {
      Pillar.discipline: PillarProgress(pillar: Pillar.discipline),
      Pillar.academics: PillarProgress(pillar: Pillar.academics),
      Pillar.fitness: PillarProgress(pillar: Pillar.fitness),
      Pillar.confidence: PillarProgress(pillar: Pillar.confidence),
      Pillar.brand: PillarProgress(pillar: Pillar.brand),
      Pillar.energy: PillarProgress(pillar: Pillar.energy),
    };
  }

  int get xpToNextLevel => level * 1000;

  double get levelProgress => (totalXP % xpToNextLevel) / xpToNextLevel;

  void addXP(int xp, Pillar pillar) {
    totalXP += xp;
    pillarProgress[pillar]?.addXP(xp);

    // Level up check
    while (totalXP >= xpToNextLevel) {
      level++;
    }
  }
}

@HiveType(typeId: 51)
enum Pillar {
  @HiveField(0)
  discipline,

  @HiveField(1)
  academics,

  @HiveField(2)
  fitness,

  @HiveField(3)
  confidence,

  @HiveField(4)
  brand,

  @HiveField(5)
  energy,
}

@HiveType(typeId: 52)
class PillarProgress extends HiveObject {
  @HiveField(0)
  late Pillar pillar;

  @HiveField(1)
  late int xp;

  @HiveField(2)
  late int level;

  PillarProgress({
    required this.pillar,
    this.xp = 0,
    this.level = 1,
  });

  int get xpToNextLevel => level * 500;

  double get levelProgress => (xp % xpToNextLevel) / xpToNextLevel;

  void addXP(int amount) {
    xp += amount;
    while (xp >= xpToNextLevel) {
      level++;
    }
  }
}

@HiveType(typeId: 53)
class Achievement extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late String iconEmoji;

  @HiveField(4)
  late DateTime unlockedAt;

  @HiveField(5)
  late Pillar relatedPillar;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconEmoji,
    required this.unlockedAt,
    required this.relatedPillar,
  });

  static List<Achievement> getAllAchievements() {
    return [
      Achievement(
        id: 'first_study',
        title: 'First Deep Focus',
        description: 'Complete your first 2-hour study session',
        iconEmoji: '📚',
        unlockedAt: DateTime.now(),
        relatedPillar: Pillar.academics,
      ),
      Achievement(
        id: 'week_streak',
        title: '7-Day Warrior',
        description: 'Maintain any streak for 7 consecutive days',
        iconEmoji: '🔥',
        unlockedAt: DateTime.now(),
        relatedPillar: Pillar.discipline,
      ),
      Achievement(
        id: 'first_workout',
        title: 'Morning Warrior',
        description: 'Complete morning workout routine',
        iconEmoji: '💪',
        unlockedAt: DateTime.now(),
        relatedPillar: Pillar.fitness,
      ),
      Achievement(
        id: 'constitution_10',
        title: 'Constitution Scholar',
        description: 'Master 10 Constitution articles',
        iconEmoji: '⚖️',
        unlockedAt: DateTime.now(),
        relatedPillar: Pillar.academics,
      ),
      Achievement(
        id: 'first_content',
        title: '7K Creator',
        description: 'Publish your first piece of content',
        iconEmoji: '🎬',
        unlockedAt: DateTime.now(),
        relatedPillar: Pillar.brand,
      ),
    ];
  }
}
