import "dart:ui";

import "package:shared_preferences/shared_preferences.dart";

/// my theme preferences
class MyThemePreferences {
  /// theme key
  // ignore: constant_identifier_names
  static const String THEME_KEY = "theme_key";

  /// theme color
  // ignore: constant_identifier_names
  static const String THEME_COLOR = "theme_color";

  /// set theme
  // ignore: avoid_positional_boolean_parameters
  Future<void> setTheme(bool value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setBool(THEME_KEY, value);
  }

  /// set theme color
  Future<void> setColor(Color value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(THEME_COLOR, value.toString());
  }

  /// get theme
  Future<bool> getTheme() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getBool(THEME_KEY) ?? false;
  }

  /// get theme color
  Future<Color> getColor() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return Color(int.parse(sharedPreferences.getString(THEME_COLOR)!));
  }
}
