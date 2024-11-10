import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_tec/src/themes/dark_mode.dart';
import 'package:shop_tec/src/themes/light_mode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;

  ThemeProvider() {
    _loadTheme(); // Lade das gespeicherte Thema beim Initialisieren
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // Toggle zwischen Light und Dark Mode und speichere die Einstellung
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
    _saveTheme(isDarkMode); // Speichere die aktuelle Einstellung
  }

  // Lade das gespeicherte Thema aus Shared Preferences
  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkModeSaved =
        prefs.getBool('isDarkMode') ?? false; // Standard: Light Mode
    themeData = isDarkModeSaved ? darkMode : lightMode;
  }

  // Speichere die aktuelle Einstellung für den Dark Mode
  void _saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }
}
