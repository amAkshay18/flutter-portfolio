import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppThemeMode {
  dark,
  light,
}

class ThemeNotifier extends StateNotifier<AppThemeMode> {
  ThemeNotifier() : super(AppThemeMode.dark);

  void toggleTheme() {
    state = state == AppThemeMode.dark 
        ? AppThemeMode.light 
        : AppThemeMode.dark;
  }

  void setTheme(AppThemeMode mode) {
    state = mode;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
  return ThemeNotifier();
});

