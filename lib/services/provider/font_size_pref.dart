import 'package:shared_preferences/shared_preferences.dart';

class MyFontSizePreferences {
  static const String FONT_SIZE_KEY = 'font_size_key';

  Future<void> setFontSize(int value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setInt(FONT_SIZE_KEY, value);
  }

  Future<int> getFontSize() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getInt(FONT_SIZE_KEY) ?? 40;
  }
}
