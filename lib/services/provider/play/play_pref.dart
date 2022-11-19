import 'package:shared_preferences/shared_preferences.dart';

class MyPlayPreferences {
  static const String PLAY_KEY = 'play_key';

  Future<void> setPlayVal(String value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(PLAY_KEY, value);
  }

  Future<String?> getPlayVal() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(PLAY_KEY);
  }
}
