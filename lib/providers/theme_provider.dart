import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../core/theme.dart';

class ThemeNotifier extends StateNotifier<AppThemeMode> {
  final Box _settingsBox;

  ThemeNotifier(this._settingsBox) : super(_loadTheme(_settingsBox));

  static AppThemeMode _loadTheme(Box box) {
    final themeIndex = box.get('themeMode', defaultValue: 1); // 1 = dark (default)
    return AppThemeMode.values[themeIndex];
  }

  void setTheme(AppThemeMode mode) {
    state = mode;
    _settingsBox.put('themeMode', mode.index);
  }

  void toggleTheme() {
    final nextIndex = (state.index + 1) % AppThemeMode.values.length;
    setTheme(AppThemeMode.values[nextIndex]);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
  final settingsBox = Hive.box('settings');
  return ThemeNotifier(settingsBox);
});
