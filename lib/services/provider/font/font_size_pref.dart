import "package:shared_preferences/shared_preferences.dart";

/// font size provider
class MyFontSizePreferences {
  /// font size key
  // ignore: constant_identifier_names
  static const String FONT_SIZE_KEY = "font_size_key";

  /// set font size
  Future<void> setFontSize(double value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setDouble(FONT_SIZE_KEY, value);
  }

  /// get font size
  Future<double> getFontSize() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(FONT_SIZE_KEY) ?? 40;
  }
}

/// font family pref
class MyFontFamilyPreferences {
  /// font family key
  // ignore: constant_identifier_names
  static const String FONT_FAMILY = "font_family";

  /// set font size
  Future<void> setFontSize(String value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(FONT_FAMILY, value);
  }

  /// get font size
  Future<String> getFontSize() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(FONT_FAMILY) ?? "";
  }
}
