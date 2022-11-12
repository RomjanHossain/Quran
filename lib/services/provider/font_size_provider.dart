import 'package:flutter/material.dart';
import 'font_size_pref.dart';

class FontSizeProvider extends ChangeNotifier {
  FontSizeProvider() {
    _fontSize = 40;
    _preferences = MyFontSizePreferences();
    getPreferences();
  }
  late int _fontSize;
  late MyFontSizePreferences _preferences;
  int get fontSize => _fontSize;

  // setting font size value
  set fontSize(int value) {
    _fontSize = value;
    _preferences.setFontSize(value);
    notifyListeners();
  }

  // getting value from preferences
  Future<void> getPreferences() async {
    _fontSize = await _preferences.getFontSize();
    notifyListeners();
  }
}
