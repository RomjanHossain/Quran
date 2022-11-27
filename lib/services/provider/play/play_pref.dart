import "package:shared_preferences/shared_preferences.dart";

/// my play pref
class MyPlayPreferences {
  /// play key
  // ignore: constant_identifier_names
  static const String PLAY_KEY = "play_key";

  /// set play val
  Future<void> setPlayVal(String value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(PLAY_KEY, value);
  }

  /// get play val
  Future<String?> getPlayVal() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(PLAY_KEY);
  }
}
