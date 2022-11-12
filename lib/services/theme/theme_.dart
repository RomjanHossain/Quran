import 'package:flutter/material.dart';
import 'theme_pref.dart';

class ModelTheme extends ChangeNotifier {
  ModelTheme() {
    _isDark = false;
    _preferences = MyThemePreferences();
    getPreferences();
  }
  late bool _isDark;
  late MyThemePreferences _preferences;
  bool get isDark => _isDark;
  //Switching the themes
  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  Future<void> getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}
