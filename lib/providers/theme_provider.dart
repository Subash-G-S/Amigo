import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  MaterialColor _primaryColor = Colors.indigo;

  ThemeMode get themeMode => _themeMode;

  MaterialColor get primaryColor => _primaryColor;

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final mode = prefs.getString("theme") ?? "system";
    final color = prefs.getInt("color") ?? Colors.indigo.value;

    switch (mode) {
      case "light":
        _themeMode = ThemeMode.light;
        break;

      case "dark":
        _themeMode = ThemeMode.dark;
        break;

      default:
        _themeMode = ThemeMode.system;
    }

    _primaryColor = _getMaterialColor(color);

    notifyListeners();
  }

  Future<void> setTheme(ThemeMode mode) async {
    _themeMode = mode;

    final prefs = await SharedPreferences.getInstance();

    if (mode == ThemeMode.light) {
      prefs.setString("theme", "light");
    } else if (mode == ThemeMode.dark) {
      prefs.setString("theme", "dark");
    } else {
      prefs.setString("theme", "system");
    }

    notifyListeners();
  }

  Future<void> setColor(MaterialColor color) async {
    _primaryColor = color;

    final prefs = await SharedPreferences.getInstance();

    prefs.setInt("color", color.value);

    notifyListeners();
  }

  MaterialColor _getMaterialColor(int value) {
    if (value == Colors.blue.value) return Colors.blue;
    if (value == Colors.green.value) return Colors.green;
    if (value == Colors.orange.value) return Colors.orange;
    if (value == Colors.red.value) return Colors.red;
    if (value == Colors.purple.value) return Colors.purple;
    if (value == Colors.teal.value) return Colors.teal;

    return Colors.indigo;
  }
}