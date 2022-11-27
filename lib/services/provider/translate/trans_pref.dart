import "package:shared_preferences/shared_preferences.dart";

/// my trans pref
class MyTranslationPreferences {
  /// trans key
  // ignore: constant_identifier_names
  static const String TRANSLATION_KEY = "translation_key";

  /// set trans val
  Future<void> setTransVal(List<String> value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setStringList(TRANSLATION_KEY, value);
  }

  /// get trans val
  Future<List<String>?> getTransVal() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(TRANSLATION_KEY);
  }
}
