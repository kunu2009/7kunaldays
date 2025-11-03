import '../models/daily_log.dart';

class AICompanion {
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning, Kunal 🧠';
    if (hour < 17) return 'Good Afternoon, Kunal 🎯';
    if (hour < 21) return 'Good Evening, Kunal 💪';
    return 'Night Mode, Kunal 🌙';
  }

  static AIResponse generateDailyGuidance({
    required DailyLog todayLog,
    required int studyStreak,
    required int fitnessStreak,
    required double avgFocus,
    required double avgEnergy,
  }) {
    // Calculate focus score
    final focusScore = _calculateFocusScore(
      todayLog: todayLog,
      avgFocus: avgFocus,
      avgEnergy: avgEnergy,
    );

    // Determine physical state
    final physicalState = _determinePhysicalState(
      energyLevel: avgEnergy,
      sleepHours: todayLog.sleepHours,
    );

    // Determine academic progress
    final academicProgress = _determineAcademicProgress(
      completionPercentage: todayLog.completionPercentage,
      studyHours: todayLog.metrics.studyHours,
    );

    // Generate next step
    final nextStep = _generateNextStep(
      todayLog: todayLog,
      focusScore: focusScore,
      physicalState: physicalState,
    );

    return AIResponse(
      focusScore: focusScore,
      physicalState: physicalState,
      academicProgress: academicProgress,
      nextStep: nextStep,
      motivationalMessage: _generateMotivationalMessage(focusScore),
    );
  }

  static int _calculateFocusScore({
    required DailyLog todayLog,
    required double avgFocus,
    required double avgEnergy,
  }) {
    // Base score from mental ratings
    double score = (avgFocus + avgEnergy) / 2;

    // Bonus for completion
    score += (todayLog.completionPercentage / 100) * 20;

    // Bonus for study hours
    if (todayLog.metrics.studyHours >= 4) score += 10;

    // Penalty for poor sleep
    if (todayLog.sleepHours < 7) score -= 10;

    return score.clamp(0, 100).round();
  }

  static String _determinePhysicalState({
    required double energyLevel,
    required double sleepHours,
  }) {
    if (energyLevel >= 8 && sleepHours >= 7.5) return 'Excellent';
    if (energyLevel >= 6 && sleepHours >= 7) return 'Good';
    if (energyLevel >= 4) return 'Moderate';
    return 'Low - Need Recovery';
  }

  static String _determineAcademicProgress({
    required double completionPercentage,
    required double studyHours,
  }) {
    if (completionPercentage >= 80 && studyHours >= 4) return 'Excellent Progress';
    if (completionPercentage >= 60 && studyHours >= 3) return 'Good Progress';
    if (completionPercentage >= 40) return 'Moderate Progress';
    return 'Needs Improvement';
  }

  static String _generateNextStep({
    required DailyLog todayLog,
    required int focusScore,
    required String physicalState,
  }) {
    final hour = DateTime.now().hour;

    // Morning (6-12)
    if (hour < 12) {
      if (!todayLog.morningChecklist['Workout']!) {
        return 'Start morning workout routine → Build energy for the day';
      }
      if (todayLog.metrics.studyHours < 2) {
        return 'Deep 90-min focus on MHCET preparation → Build momentum';
      }
      return 'Continue morning routine → Maintain consistency';
    }

    // Afternoon (12-17)
    if (hour < 17) {
      if (todayLog.metrics.studyHours < 3) {
        return 'Study Block 2 → Focus on Board subjects for 2 hours';
      }
      return 'Review college notes → Prepare for evening 7K work';
    }

    // Evening (17-22)
    if (hour < 22) {
      if (todayLog.sevenKActions.isEmpty) {
        return '7K work session → Create content or plan strategy';
      }
      if (todayLog.metrics.studyHours < 4) {
        return 'Final study push → Complete daily academic goal';
      }
      return 'Evening reflection → Plan tomorrow & wind down';
    }

    // Night (22+)
    if (todayLog.gratitude == null || todayLog.gratitude!.isEmpty) {
      return 'Complete reflection → Journal insights & gratitude';
    }
    return 'Sleep setup → Aim for 7.5 hrs quality rest';
  }

  static String _generateMotivationalMessage(int focusScore) {
    if (focusScore >= 85) {
      return "You're 1% closer to your vision today. Relentless progress.";
    } else if (focusScore >= 70) {
      return "Solid work. Tomorrow, push 1% harder. Stay disciplined.";
    } else if (focusScore >= 50) {
      return "Recovery day or focus slip? Reset. Execute tomorrow.";
    } else {
      return "Low output today. Analyze, adjust, attack tomorrow.";
    }
  }

  static List<String> getDailyMissions(DateTime date) {
    return [
      '📚 Complete 4+ hours of focused study',
      '💪 Finish morning workout routine',
      '🎯 Master 2 Constitution articles',
      '🎬 Create 1 piece of 7K content',
      '💧 Drink 3L+ water',
      '🧠 Maintain 80%+ focus score',
    ];
  }

  static String getTimeBlockSuggestion() {
    final hour = DateTime.now().hour;

    if (hour >= 6 && hour < 8) {
      return '🌅 Morning Routine: Workout + Study Block 1';
    } else if (hour >= 8 && hour < 11) {
      return '📚 Deep Focus: Board Subject Study';
    } else if (hour >= 11 && hour < 18) {
      return '🏫 College Mode: Focus + Productive Breaks';
    } else if (hour >= 18 && hour < 20) {
      return '🎬 7K Work: Content Creation Session';
    } else if (hour >= 20 && hour < 22) {
      return '📖 Study Block 2: MHCET Practice';
    } else if (hour >= 22 && hour < 24) {
      return '🌙 Night Routine: Reflection + Planning';
    } else {
      return '😴 Sleep Mode: Recovery is Growth';
    }
  }

  static List<String> getInsights(List<DailyLog> recentLogs) {
    if (recentLogs.length < 3) {
      return ['Track 3+ days to unlock AI insights'];
    }

    List<String> insights = [];

    // Study pattern
    double avgStudy = recentLogs.map((l) => l.metrics.studyHours).reduce((a, b) => a + b) / recentLogs.length;
    if (avgStudy >= 4) {
      insights.add('🎯 Study Consistency: Excellent (${avgStudy.toStringAsFixed(1)}h/day avg)');
    } else {
      insights.add('📈 Study Goal: Need ${(4 - avgStudy).toStringAsFixed(1)}h more daily');
    }

    // Sleep pattern
    double avgSleep = recentLogs.map((l) => l.sleepHours).reduce((a, b) => a + b) / recentLogs.length;
    if (avgSleep < 7) {
      insights.add('⚠️ Sleep Debt: Averaging ${avgSleep.toStringAsFixed(1)}h → Target 7.5h');
    } else {
      insights.add('✅ Sleep Quality: Good (${avgSleep.toStringAsFixed(1)}h avg)');
    }

    // Fitness pattern
    double avgFitness = recentLogs.map((l) => l.metrics.fitnessMinutes.toDouble()).reduce((a, b) => a + b) / recentLogs.length;
    if (avgFitness >= 30) {
      insights.add('💪 Fitness Streak: Strong (${avgFitness.toStringAsFixed(0)}min avg)');
    } else {
      insights.add('🏋️ Fitness Opportunity: Add ${(30 - avgFitness).toStringAsFixed(0)}min daily');
    }

    return insights;
  }
}

class AIResponse {
  final int focusScore;
  final String physicalState;
  final String academicProgress;
  final String nextStep;
  final String motivationalMessage;

  AIResponse({
    required this.focusScore,
    required this.physicalState,
    required this.academicProgress,
    required this.nextStep,
    required this.motivationalMessage,
  });
}
