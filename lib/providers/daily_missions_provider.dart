import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

class DailyMission {
  final String name;
  final String target;
  bool completed;
  double progress;
  final String category;

  DailyMission({
    required this.name,
    required this.target,
    this.completed = false,
    this.progress = 0.0,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'target': target,
        'completed': completed,
        'progress': progress,
        'category': category,
      };

  factory DailyMission.fromJson(Map<String, dynamic> json) => DailyMission(
        name: json['name'],
        target: json['target'],
        completed: json['completed'] ?? false,
        progress: json['progress'] ?? 0.0,
        category: json['category'],
      );
}

class DailyMissionsNotifier extends StateNotifier<Map<String, List<DailyMission>>> {
  DailyMissionsNotifier() : super({
    'academics': [],
    'fitness': [],
    'brand': [],
    'confidence': [],
  }) {
    _loadMissions();
  }

  static const String _boxName = 'daily_missions';

  Future<void> _loadMissions() async {
    final box = await Hive.openBox(_boxName);
    final String? savedDate = box.get('date');
    final today = DateTime.now().toIso8601String().split('T')[0];

    // Reset if it's a new day - restore default missions
    if (savedDate != today) {
      _initializeDefault();
      await box.put('date', today);
      await _saveMissions();
    } else {
      final String? json = box.get('missions');
      if (json != null) {
        try {
          final Map<String, dynamic> decoded = jsonDecode(json);
          final Map<String, List<DailyMission>> missions = {};
          
          decoded.forEach((category, missionsList) {
            missions[category] = (missionsList as List)
                .map((m) => DailyMission.fromJson(m as Map<String, dynamic>))
                .toList();
          });
          
          state = missions;
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
      'academics': [
        DailyMission(name: 'Complete 2 deep study blocks (History + Constitution)', target: '240 minutes total', category: 'academics'),
        DailyMission(name: 'Revise one subject summary (write 1-page notes)', target: '45 minutes', category: 'academics'),
        DailyMission(name: 'Attempt 1 Legal Aptitude mini-mock (timed 30 min)', target: '1 test', category: 'academics'),
        DailyMission(name: 'Review last mock\'s mistakes (write 5 corrections)', target: '30 minutes', category: 'academics'),
        DailyMission(name: 'Constitution (Articles 1–10) — read + 10 active recall Qs', target: '30 minutes', category: 'academics'),
      ],
      'fitness': [
        DailyMission(name: 'Morning workout (Jumping Jacks, Pushups, Squats, Hanging, Plank)', target: 'Completed sets', category: 'fitness'),
        DailyMission(name: 'Drink 2.5 L water today', target: '2.5 liters', category: 'fitness'),
        DailyMission(name: 'Evening mobility walk 20 min', target: '20 min logged', category: 'fitness'),
        DailyMission(name: 'Posture checks (5 times during day)', target: '5 checks', category: 'fitness'),
        DailyMission(name: 'Sleep by 10:45 PM', target: 'Lights off by 10:45', category: 'fitness'),
      ],
      'brand': [
        DailyMission(name: 'Draft 1 7K short script (30–60 sec idea)', target: '1 script', category: 'brand'),
        DailyMission(name: 'Log 3 content ideas into Vault', target: '3 ideas', category: 'brand'),
        DailyMission(name: 'Edit/Upload 1 short (if recorded)', target: '1 upload', category: 'brand'),
      ],
      'confidence': [
        DailyMission(name: 'Mirror talk', target: '3 minutes recorded', category: 'confidence'),
        DailyMission(name: 'Read aloud (10 min) to practice voice', target: '10 minutes', category: 'confidence'),
        DailyMission(name: 'Start 1 conversation outside comfort zone', target: '1 conversation', category: 'confidence'),
      ],
    };
  }

  Future<void> _saveMissions() async {
    final box = await Hive.openBox(_boxName);
    final Map<String, dynamic> toSave = {};
    
    state.forEach((category, missions) {
      toSave[category] = missions.map((m) => m.toJson()).toList();
    });
    
    await box.put('missions', jsonEncode(toSave));
  }

  void addMission(String category, String name, String target) {
    final newMission = DailyMission(
      name: name,
      target: target,
      category: category,
    );
    
    state = {
      ...state,
      category: [...state[category]!, newMission],
    };
    _saveMissions();
  }

  void toggleMission(String category, int index) {
    final missions = List<DailyMission>.from(state[category]!);
    missions[index].completed = !missions[index].completed;
    missions[index].progress = missions[index].completed ? 1.0 : 0.0;
    
    final newState = Map<String, List<DailyMission>>.from(state);
    newState[category] = missions;
    state = newState;
    _saveMissions();
  }

  void updateProgress(String category, int index, double progress) {
    final missions = List<DailyMission>.from(state[category]!);
    missions[index].progress = progress;
    missions[index].completed = progress >= 1.0;
    
    final newState = Map<String, List<DailyMission>>.from(state);
    newState[category] = missions;
    state = newState;
    _saveMissions();
  }

  void deleteMission(String category, int index) {
    final missions = List<DailyMission>.from(state[category]!);
    missions.removeAt(index);
    
    final newState = Map<String, List<DailyMission>>.from(state);
    newState[category] = missions;
    state = newState;
    _saveMissions();
  }

  int get totalMissions {
    return state.values.fold(0, (sum, list) => sum + list.length);
  }

  int get completedMissions {
    return state.values.fold(0, (sum, list) => 
      sum + list.where((m) => m.completed).length);
  }
}

final dailyMissionsProvider = StateNotifierProvider<DailyMissionsNotifier, Map<String, List<DailyMission>>>((ref) {
  return DailyMissionsNotifier();
});
