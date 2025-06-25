import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart'; // Assuming your AppTheme is in this path

// Define a state for the theme
class ThemeState {
  final ThemeData themeData;
  final bool isDarkMode;

  ThemeState(this.themeData, this.isDarkMode);
}

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeModeKey = 'themeMode';

  ThemeCubit() : super(ThemeState(AppTheme.lightTheme, false)) {
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_themeModeKey) ?? false; // Default to light mode
    if (isDarkMode) {
      emit(ThemeState(AppTheme.darkTheme, true));
    } else {
      emit(ThemeState(AppTheme.lightTheme, false));
    }
  }

  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (state.isDarkMode) {
      await prefs.setBool(_themeModeKey, false);
      emit(ThemeState(AppTheme.lightTheme, false));
    } else {
      await prefs.setBool(_themeModeKey, true);
      emit(ThemeState(AppTheme.darkTheme, true));
    }
  }
}
