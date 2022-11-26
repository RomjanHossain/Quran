import 'package:flutter/material.dart';
import 'theme_pref.dart';

class ModelTheme extends ChangeNotifier {
  ModelTheme() {
    _isDark = false;
    _color = Colors.blue;
    _preferences = MyThemePreferences();
    getPreferences();
    getColor();
  }
  late bool _isDark;
  late Color _color;
  late MyThemePreferences _preferences;
  bool get isDark => _isDark;
  Color get color => _color;

  //Switching the themes
  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  set color(Color value) {
    _color = value;
    _preferences.setColor(value);
    notifyListeners();
  }

  Future<void> getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }

  Future<void> getColor() async {
    _color = await _preferences.getColor();
    notifyListeners();
  }
}
