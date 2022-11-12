import 'package:shared_preferences/shared_preferences.dart';

class MyTranslationPreferences {
  static const String TRANSLATION_KEY = 'translation_key';

  Future<void> setTransVal(List<String> value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setStringList(TRANSLATION_KEY, value);
  }

  Future<List<String>?> getTransVal() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(TRANSLATION_KEY);
  }
}
