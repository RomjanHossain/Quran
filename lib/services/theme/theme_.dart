import "dart:async";

import "package:flutter/material.dart";
import "package:quran/services/theme/theme_pref.dart";

/// model theme
class ModelTheme extends ChangeNotifier {
  /// constructor
  ModelTheme() {
    _isDark = false;
    _color = Colors.blue;
    _preferences = MyThemePreferences();
    unawaited(getPreferences());
    unawaited(getColor());
  }
  late bool _isDark;
  late Color _color;
  late MyThemePreferences _preferences;

  /// is dark
  bool get isDark => _isDark;

  /// color
  Color get color => _color;

  //Switching the themes
  set isDark(bool value) {
    _isDark = value;
    unawaited(_preferences.setTheme(value));
    notifyListeners();
  }

  set color(Color value) {
    _color = value;
    unawaited(_preferences.setColor(value));
    notifyListeners();
  }

  /// getting value from preferences
  Future<void> getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }

  /// get color
  Future<void> getColor() async {
    _color = await _preferences.getColor();
    notifyListeners();
  }
}
