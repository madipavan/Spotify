import 'package:flutter/material.dart';

class ChooseModeProvider extends ChangeNotifier {
  bool _isDark = true;

  bool? get isDark => _isDark;

  ThemeMode get currentTheme => _isDark ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(val) {
    _isDark = val;
    notifyListeners();
  }
}
