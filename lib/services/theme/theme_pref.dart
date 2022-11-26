import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class MyThemePreferences {
  static const String THEME_KEY = 'theme_key';
  static const String THEME_COLOR = 'theme_color';

  Future<void> setTheme(bool value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool(THEME_KEY, value);
  }

  // set theme color
  Future<void> setColor(Color value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(THEME_COLOR, value.toString());
  }

  Future<bool> getTheme() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getBool(THEME_KEY) ?? false;
  }

  // get theme color
  Future<Color> getColor() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return Color(int.parse(sharedPreferences.getString(THEME_COLOR)!));
  }
}
