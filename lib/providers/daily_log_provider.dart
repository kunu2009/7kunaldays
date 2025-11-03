import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/daily_log.dart';
import '../models/nutrition_entry.dart';

// Daily Log Repository
class DailyLogRepository {
  final Box<DailyLog> _box = Hive.box<DailyLog>('daily_logs');

  DailyLog getTodayLog() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var log = _box.get(today);

    if (log == null) {
      log = DailyLog(date: today);
      _box.put(today, log);
    }

    return log;
  }

  DailyLog? getLogByDate(String date) {
    return _box.get(date);
  }

  Future<void> saveLog(DailyLog log) async {
    await _box.put(log.date, log);
  }

  List<DailyLog> getAllLogs() {
    return _box.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  List<DailyLog> getLogsInRange(DateTime start, DateTime end) {
    return _box.values.where((log) {
      final date = DateTime.parse(log.date);
      return date.isAfter(start.subtract(const Duration(days: 1))) &&
          date.isBefore(end.add(const Duration(days: 1)));
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  // Get last 7 days for weekly analysis
  List<DailyLog> getLastWeek() {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    return getLogsInRange(weekAgo, now);
  }

  // Get current month logs
  List<DailyLog> getCurrentMonth() {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(now.year, now.month + 1, 0);
    return getLogsInRange(monthStart, monthEnd);
  }

  // Calculate study streak
  int getStudyStreak() {
    final logs = getAllLogs();
    int streak = 0;
    DateTime currentDate = DateTime.now();

    for (var log in logs) {
      final logDate = DateTime.parse(log.date);
      final dayDiff = currentDate.difference(logDate).inDays;

      if (dayDiff == streak && log.metrics.studyHours >= 2.0) {
        streak++;
        currentDate = logDate;
      } else {
        break;
      }
    }

    return streak;
  }

  // Calculate fitness streak
  int getFitnessStreak() {
    final logs = getAllLogs();
    int streak = 0;
    DateTime currentDate = DateTime.now();

    for (var log in logs) {
      final logDate = DateTime.parse(log.date);
      final dayDiff = currentDate.difference(logDate).inDays;

      if (dayDiff == streak && log.metrics.fitnessMinutes >= 30) {
        streak++;
        currentDate = logDate;
      } else {
        break;
      }
    }

    return streak;
  }

  // Calculate journal streak
  int getJournalStreak() {
    final logs = getAllLogs();
    int streak = 0;
    DateTime currentDate = DateTime.now();

    for (var log in logs) {
      final logDate = DateTime.parse(log.date);
      final dayDiff = currentDate.difference(logDate).inDays;

      if (dayDiff == streak && log.journalDone) {
        streak++;
        currentDate = logDate;
      } else {
        break;
      }
    }

    return streak;
  }

  Future<void> deleteLog(String date) async {
    await _box.delete(date);
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}

// Providers
final dailyLogRepositoryProvider = Provider<DailyLogRepository>((ref) {
  return DailyLogRepository();
});

final todayLogProvider = StateNotifierProvider<TodayLogNotifier, DailyLog>((ref) {
  final repository = ref.watch(dailyLogRepositoryProvider);
  return TodayLogNotifier(repository);
});

class TodayLogNotifier extends StateNotifier<DailyLog> {
  final DailyLogRepository _repository;

  TodayLogNotifier(this._repository) : super(_repository.getTodayLog());

  void updateMood(String mood) {
    state.mood = mood;
    _save();
  }

  void updateSleepHours(double hours) {
    state.sleepHours = hours;
    _save();
  }

  void updateTheme(String theme) {
    state.theme = theme;
    _save();
  }

  void toggleMorningTask(String task) {
    final updatedChecklist = Map<String, bool>.from(state.morningChecklist);
    updatedChecklist[task] = !(updatedChecklist[task] ?? false);
    
    // Create new DailyLog to trigger rebuild
    final newLog = DailyLog(
      date: state.date,
      mood: state.mood,
      sleepHours: state.sleepHours,
      theme: state.theme,
      morningChecklist: updatedChecklist,
      collegeChecklist: state.collegeChecklist,
      eveningChecklist: state.eveningChecklist,
      nightChecklist: state.nightChecklist,
      metrics: state.metrics,
      mentalRatings: state.mentalRatings,
    );
    
    // Copy all other fields
    newLog.morningWins = state.morningWins;
    newLog.collegeInteractions = state.collegeInteractions;
    newLog.eveningIdeas = state.eveningIdeas;
    newLog.oneGreatThing = state.oneGreatThing;
    newLog.oneImprovement = state.oneImprovement;
    newLog.gratitude = state.gratitude;
    newLog.topThreeWins = state.topThreeWins;
    newLog.whatSlowedDown = state.whatSlowedDown;
    newLog.howToImprove = state.howToImprove;
    newLog.lessonOfTheDay = state.lessonOfTheDay;
    newLog.thoughtsAndIdeas = state.thoughtsAndIdeas;
    newLog.sevenKActions = state.sevenKActions;
    newLog.constitutionProgress = state.constitutionProgress;
    newLog.nutritionLog = state.nutritionLog;
    newLog.waterIntake = state.waterIntake;
    newLog.timeslept = state.timeslept;
    newLog.phoneUseAfter11PM = state.phoneUseAfter11PM;
    newLog.journalDone = state.journalDone;
    newLog.nextDayPrioritySet = state.nextDayPrioritySet;
    newLog.exported = state.exported;
    
    state = newLog;
    _save();
  }

  void toggleCollegeTask(String task) {
    final updatedChecklist = Map<String, bool>.from(state.collegeChecklist);
    updatedChecklist[task] = !(updatedChecklist[task] ?? false);
    
    final newLog = DailyLog(
      date: state.date,
      mood: state.mood,
      sleepHours: state.sleepHours,
      theme: state.theme,
      morningChecklist: state.morningChecklist,
      collegeChecklist: updatedChecklist,
      eveningChecklist: state.eveningChecklist,
      nightChecklist: state.nightChecklist,
      metrics: state.metrics,
      mentalRatings: state.mentalRatings,
    );
    
    newLog.morningWins = state.morningWins;
    newLog.collegeInteractions = state.collegeInteractions;
    newLog.eveningIdeas = state.eveningIdeas;
    newLog.oneGreatThing = state.oneGreatThing;
    newLog.oneImprovement = state.oneImprovement;
    newLog.gratitude = state.gratitude;
    newLog.topThreeWins = state.topThreeWins;
    newLog.whatSlowedDown = state.whatSlowedDown;
    newLog.howToImprove = state.howToImprove;
    newLog.lessonOfTheDay = state.lessonOfTheDay;
    newLog.thoughtsAndIdeas = state.thoughtsAndIdeas;
    newLog.sevenKActions = state.sevenKActions;
    newLog.constitutionProgress = state.constitutionProgress;
    newLog.nutritionLog = state.nutritionLog;
    newLog.waterIntake = state.waterIntake;
    newLog.timeslept = state.timeslept;
    newLog.phoneUseAfter11PM = state.phoneUseAfter11PM;
    newLog.journalDone = state.journalDone;
    newLog.nextDayPrioritySet = state.nextDayPrioritySet;
    newLog.exported = state.exported;
    
    state = newLog;
    _save();
  }

  void toggleEveningTask(String task) {
    final updatedChecklist = Map<String, bool>.from(state.eveningChecklist);
    updatedChecklist[task] = !(updatedChecklist[task] ?? false);
    
    final newLog = DailyLog(
      date: state.date,
      mood: state.mood,
      sleepHours: state.sleepHours,
      theme: state.theme,
      morningChecklist: state.morningChecklist,
      collegeChecklist: state.collegeChecklist,
      eveningChecklist: updatedChecklist,
      nightChecklist: state.nightChecklist,
      metrics: state.metrics,
      mentalRatings: state.mentalRatings,
    );
    
    newLog.morningWins = state.morningWins;
    newLog.collegeInteractions = state.collegeInteractions;
    newLog.eveningIdeas = state.eveningIdeas;
    newLog.oneGreatThing = state.oneGreatThing;
    newLog.oneImprovement = state.oneImprovement;
    newLog.gratitude = state.gratitude;
    newLog.topThreeWins = state.topThreeWins;
    newLog.whatSlowedDown = state.whatSlowedDown;
    newLog.howToImprove = state.howToImprove;
    newLog.lessonOfTheDay = state.lessonOfTheDay;
    newLog.thoughtsAndIdeas = state.thoughtsAndIdeas;
    newLog.sevenKActions = state.sevenKActions;
    newLog.constitutionProgress = state.constitutionProgress;
    newLog.nutritionLog = state.nutritionLog;
    newLog.waterIntake = state.waterIntake;
    newLog.timeslept = state.timeslept;
    newLog.phoneUseAfter11PM = state.phoneUseAfter11PM;
    newLog.journalDone = state.journalDone;
    newLog.nextDayPrioritySet = state.nextDayPrioritySet;
    newLog.exported = state.exported;
    
    state = newLog;
    _save();
  }

  void toggleNightTask(String task) {
    final updatedChecklist = Map<String, bool>.from(state.nightChecklist);
    updatedChecklist[task] = !(updatedChecklist[task] ?? false);
    
    final newLog = DailyLog(
      date: state.date,
      mood: state.mood,
      sleepHours: state.sleepHours,
      theme: state.theme,
      morningChecklist: state.morningChecklist,
      collegeChecklist: state.collegeChecklist,
      eveningChecklist: state.eveningChecklist,
      nightChecklist: updatedChecklist,
      metrics: state.metrics,
      mentalRatings: state.mentalRatings,
    );
    
    newLog.morningWins = state.morningWins;
    newLog.collegeInteractions = state.collegeInteractions;
    newLog.eveningIdeas = state.eveningIdeas;
    newLog.oneGreatThing = state.oneGreatThing;
    newLog.oneImprovement = state.oneImprovement;
    newLog.gratitude = state.gratitude;
    newLog.topThreeWins = state.topThreeWins;
    newLog.whatSlowedDown = state.whatSlowedDown;
    newLog.howToImprove = state.howToImprove;
    newLog.lessonOfTheDay = state.lessonOfTheDay;
    newLog.thoughtsAndIdeas = state.thoughtsAndIdeas;
    newLog.sevenKActions = state.sevenKActions;
    newLog.constitutionProgress = state.constitutionProgress;
    newLog.nutritionLog = state.nutritionLog;
    newLog.waterIntake = state.waterIntake;
    newLog.timeslept = state.timeslept;
    newLog.phoneUseAfter11PM = state.phoneUseAfter11PM;
    newLog.journalDone = state.journalDone;
    newLog.nextDayPrioritySet = state.nextDayPrioritySet;
    newLog.exported = state.exported;
    
    state = newLog;
    _save();
  }

  // Add new task to a time block
  void addTask(String timeBlock, String taskName) {
    Map<String, bool> updatedChecklist;
    
    switch (timeBlock) {
      case 'morning':
        updatedChecklist = Map<String, bool>.from(state.morningChecklist);
        updatedChecklist[taskName] = false;
        state.morningChecklist = updatedChecklist;
        break;
      case 'college':
        updatedChecklist = Map<String, bool>.from(state.collegeChecklist);
        updatedChecklist[taskName] = false;
        state.collegeChecklist = updatedChecklist;
        break;
      case 'evening':
        updatedChecklist = Map<String, bool>.from(state.eveningChecklist);
        updatedChecklist[taskName] = false;
        state.eveningChecklist = updatedChecklist;
        break;
      case 'night':
        updatedChecklist = Map<String, bool>.from(state.nightChecklist);
        updatedChecklist[taskName] = false;
        state.nightChecklist = updatedChecklist;
        break;
    }
    
    // Create new log to trigger rebuild
    final newLog = DailyLog(
      date: state.date,
      mood: state.mood,
      sleepHours: state.sleepHours,
      theme: state.theme,
      morningChecklist: state.morningChecklist,
      collegeChecklist: state.collegeChecklist,
      eveningChecklist: state.eveningChecklist,
      nightChecklist: state.nightChecklist,
      metrics: state.metrics,
      mentalRatings: state.mentalRatings,
    );
    
    newLog.morningWins = state.morningWins;
    newLog.collegeInteractions = state.collegeInteractions;
    newLog.eveningIdeas = state.eveningIdeas;
    newLog.oneGreatThing = state.oneGreatThing;
    newLog.oneImprovement = state.oneImprovement;
    newLog.gratitude = state.gratitude;
    newLog.topThreeWins = state.topThreeWins;
    newLog.whatSlowedDown = state.whatSlowedDown;
    newLog.howToImprove = state.howToImprove;
    newLog.lessonOfTheDay = state.lessonOfTheDay;
    newLog.thoughtsAndIdeas = state.thoughtsAndIdeas;
    newLog.sevenKActions = state.sevenKActions;
    newLog.constitutionProgress = state.constitutionProgress;
    newLog.nutritionLog = state.nutritionLog;
    newLog.waterIntake = state.waterIntake;
    newLog.timeslept = state.timeslept;
    newLog.phoneUseAfter11PM = state.phoneUseAfter11PM;
    newLog.journalDone = state.journalDone;
    newLog.nextDayPrioritySet = state.nextDayPrioritySet;
    newLog.exported = state.exported;
    
    state = newLog;
    _save();
  }

  // Remove task from a time block
  void removeTask(String timeBlock, String taskName) {
    Map<String, bool> updatedChecklist;
    
    switch (timeBlock) {
      case 'morning':
        updatedChecklist = Map<String, bool>.from(state.morningChecklist);
        updatedChecklist.remove(taskName);
        state.morningChecklist = updatedChecklist;
        break;
      case 'college':
        updatedChecklist = Map<String, bool>.from(state.collegeChecklist);
        updatedChecklist.remove(taskName);
        state.collegeChecklist = updatedChecklist;
        break;
      case 'evening':
        updatedChecklist = Map<String, bool>.from(state.eveningChecklist);
        updatedChecklist.remove(taskName);
        state.eveningChecklist = updatedChecklist;
        break;
      case 'night':
        updatedChecklist = Map<String, bool>.from(state.nightChecklist);
        updatedChecklist.remove(taskName);
        state.nightChecklist = updatedChecklist;
        break;
    }
    
    // Create new log to trigger rebuild
    final newLog = DailyLog(
      date: state.date,
      mood: state.mood,
      sleepHours: state.sleepHours,
      theme: state.theme,
      morningChecklist: state.morningChecklist,
      collegeChecklist: state.collegeChecklist,
      eveningChecklist: state.eveningChecklist,
      nightChecklist: state.nightChecklist,
      metrics: state.metrics,
      mentalRatings: state.mentalRatings,
    );
    
    newLog.morningWins = state.morningWins;
    newLog.collegeInteractions = state.collegeInteractions;
    newLog.eveningIdeas = state.eveningIdeas;
    newLog.oneGreatThing = state.oneGreatThing;
    newLog.oneImprovement = state.oneImprovement;
    newLog.gratitude = state.gratitude;
    newLog.topThreeWins = state.topThreeWins;
    newLog.whatSlowedDown = state.whatSlowedDown;
    newLog.howToImprove = state.howToImprove;
    newLog.lessonOfTheDay = state.lessonOfTheDay;
    newLog.thoughtsAndIdeas = state.thoughtsAndIdeas;
    newLog.sevenKActions = state.sevenKActions;
    newLog.constitutionProgress = state.constitutionProgress;
    newLog.nutritionLog = state.nutritionLog;
    newLog.waterIntake = state.waterIntake;
    newLog.timeslept = state.timeslept;
    newLog.phoneUseAfter11PM = state.phoneUseAfter11PM;
    newLog.journalDone = state.journalDone;
    newLog.nextDayPrioritySet = state.nextDayPrioritySet;
    newLog.exported = state.exported;
    
    state = newLog;
    _save();
  }

  void updateReflection(String field, String value) {
    switch (field) {
      case 'morningWins':
        state.morningWins = value;
        break;
      case 'collegeInteractions':
        state.collegeInteractions = value;
        break;
      case 'eveningIdeas':
        state.eveningIdeas = value;
        break;
      case 'oneGreatThing':
        state.oneGreatThing = value;
        break;
      case 'oneImprovement':
        state.oneImprovement = value;
        break;
      case 'gratitude':
        state.gratitude = value;
        break;
      case 'whatSlowedDown':
        state.whatSlowedDown = value;
        break;
      case 'howToImprove':
        state.howToImprove = value;
        break;
      case 'lessonOfTheDay':
        state.lessonOfTheDay = value;
        break;
      case 'thoughtsAndIdeas':
        state.thoughtsAndIdeas = value;
        break;
    }
    _save();
  }

  void updateMetrics({
    double? studyHours,
    int? fitnessMinutes,
    double? screenTime,
    int? steps,
    double? weight,
  }) {
    if (studyHours != null) state.metrics.studyHours = studyHours;
    if (fitnessMinutes != null) state.metrics.fitnessMinutes = fitnessMinutes;
    if (screenTime != null) state.metrics.screenTime = screenTime;
    if (steps != null) state.metrics.steps = steps;
    if (weight != null) state.metrics.weight = weight;
    _save();
  }

  void updateMentalRating(String type, int value) {
    switch (type) {
      case 'focus':
        state.mentalRatings.focus = value;
        break;
      case 'energy':
        state.mentalRatings.energy = value;
        break;
      case 'mood':
        state.mentalRatings.mood = value;
        break;
      case 'confidence':
        state.mentalRatings.confidence = value;
        break;
      case 'selfControl':
        state.mentalRatings.selfControl = value;
        break;
    }
    _save();
  }

  void addSevenKAction(String action) {
    state.sevenKActions.add(SevenKAction(action: action));
    _save();
  }

  void updateConstitutionProgress(int articles) {
    state.constitutionProgress = articles;
    _save();
  }

  void addNutritionEntry(String time, String food, {String? notes}) {
    state.nutritionLog.add(
      NutritionEntry(time: time, food: food, notes: notes),
    );
    _save();
  }

  void updateWaterIntake(double liters) {
    state.waterIntake = liters;
    _save();
  }

  void updateNightClosure({
    String? timeslept,
    bool? phoneUse,
    bool? journalDone,
    bool? nextDaySet,
  }) {
    if (timeslept != null) state.timeslept = timeslept;
    if (phoneUse != null) state.phoneUseAfter11PM = phoneUse;
    if (journalDone != null) state.journalDone = journalDone;
    if (nextDaySet != null) state.nextDayPrioritySet = nextDaySet;
    _save();
  }

  void addTopWin(String win) {
    state.topThreeWins ??= [];
    if (state.topThreeWins!.length < 3) {
      state.topThreeWins!.add(win);
      _save();
    }
  }

  void copyFromYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final yesterdayDate = DateFormat('yyyy-MM-dd').format(yesterday);
    final yesterdayLog = _repository.getLogByDate(yesterdayDate);

    if (yesterdayLog != null) {
      // Copy uncompleted tasks
      for (var entry in yesterdayLog.morningChecklist.entries) {
        if (!entry.value) {
          state.morningChecklist[entry.key] = false;
        }
      }
      for (var entry in yesterdayLog.eveningChecklist.entries) {
        if (!entry.value) {
          state.eveningChecklist[entry.key] = false;
        }
      }
      _save();
    }
  }

  Future<void> _save() async {
    await _repository.saveLog(state);
    // Trigger rebuild
    state = state;
  }

  void refresh() {
    state = _repository.getTodayLog();
  }
}

// Analytics providers
final studyStreakProvider = Provider<int>((ref) {
  final repository = ref.watch(dailyLogRepositoryProvider);
  return repository.getStudyStreak();
});

final fitnessStreakProvider = Provider<int>((ref) {
  final repository = ref.watch(dailyLogRepositoryProvider);
  return repository.getFitnessStreak();
});

final journalStreakProvider = Provider<int>((ref) {
  final repository = ref.watch(dailyLogRepositoryProvider);
  return repository.getJournalStreak();
});

final weeklyLogsProvider = Provider<List<DailyLog>>((ref) {
  final repository = ref.watch(dailyLogRepositoryProvider);
  return repository.getLastWeek();
});

final monthlyLogsProvider = Provider<List<DailyLog>>((ref) {
  final repository = ref.watch(dailyLogRepositoryProvider);
  return repository.getCurrentMonth();
});
