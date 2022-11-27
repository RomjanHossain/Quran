import "package:shared_preferences/shared_preferences.dart";

class MyFontSizePreferences {
  static const String FONT_SIZE_KEY = "font_size_key";

  Future<void> setFontSize(double value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setDouble(FONT_SIZE_KEY, value);
  }

  Future<double> getFontSize() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(FONT_SIZE_KEY) ?? 40;
  }
}

/// font family pref
class MyFontFamilyPreferences {
  /// font family
  // ignore: constant_identifier_names
  static const String FONT_FAMILY = "font_family";

  /// set font family
  Future<void> setFontFamily(String value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(FONT_FAMILY, value);
  }

  /// get font family
  Future<String> getFontFamily() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(FONT_FAMILY) ?? "uthmani";
  }
}
