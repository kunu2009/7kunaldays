import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

class TodayMissionsNotifier extends StateNotifier<Map<String, bool>> {
  TodayMissionsNotifier() : super({}) {
    _loadMissions();
  }

  static const String _boxName = 'today_missions';

  Future<void> _loadMissions() async {
    final box = await Hive.openBox(_boxName);
    final String? savedDate = box.get('date');
    final today = DateTime.now().toIso8601String().split('T')[0];

    // Reset if it's a new day
    if (savedDate != today) {
      state = {
        '📚 Complete 4+ hours of focused study': false,
        '💪 Finish morning workout routine': false,
        '🎯 Master 2 Constitution articles': false,
        '🎬 Create 1 piece of 7K content': false,
        '💧 Drink 3L+ water': false,
        '🧠 Maintain 80%+ focus score': false,
      };
      await box.put('date', today);
      await _saveMissions();
    } else {
      final String? json = box.get('missions');
      if (json != null) {
        try {
          final Map<String, dynamic> decoded = jsonDecode(json);
          state = decoded.map((key, value) => MapEntry(key, value as bool));
        } catch (e) {
          _initializeDefault();
        }
      } else {
        _initializeDefault();
      }
    }
  }

  void _initializeDefault() {
    state = {
      '📚 Complete 4+ hours of focused study': false,
      '💪 Finish morning workout routine': false,
      '🎯 Master 2 Constitution articles': false,
      '🎬 Create 1 piece of 7K content': false,
      '💧 Drink 3L+ water': false,
      '🧠 Maintain 80%+ focus score': false,
    };
  }

  Future<void> _saveMissions() async {
    final box = await Hive.openBox(_boxName);
    await box.put('missions', jsonEncode(state));
  }

  void toggleMission(String mission) {
    state = {
      ...state,
      mission: !(state[mission] ?? false),
    };
    _saveMissions();
  }

  void addMission(String mission) {
    state = {
      ...state,
      mission: false,
    };
    _saveMissions();
  }

  void removeMission(String mission) {
    final newState = Map<String, bool>.from(state);
    newState.remove(mission);
    state = newState;
    _saveMissions();
  }
}

final todayMissionsProvider = StateNotifierProvider<TodayMissionsNotifier, Map<String, bool>>((ref) {
  return TodayMissionsNotifier();
});
