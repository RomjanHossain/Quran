import "dart:async";

import "package:flutter/material.dart";
import "package:quran/services/provider/font/font_size_pref.dart";

/// font size prov
class FontSizeProvider extends ChangeNotifier {
  /// constructor
  FontSizeProvider() {
    _fontSize = 40;
    _arabicFontFamily = "uthmani";
    _isBn = false;
    _preferences = MyFontSizePreferences();
    _fontFamilyPreferences = MyFontFamilyPreferences();

    unawaited(getPreferences());
    unawaited(getPreferences2());
  }

  /// arabic font size
  late double _fontSize;

  /// arabic font family
  late String _arabicFontFamily;

  /// arabic font pref
  late MyFontSizePreferences _preferences;

  /// arabic font pref
  late MyFontFamilyPreferences _fontFamilyPreferences;

  /// get font size
  double get fontSize => _fontSize;

  /// get font family
  String get arabicFontFamily => _arabicFontFamily;
  // is bangla name
  late bool _isBn;

  /// get is bangla name
  bool get isBn => _isBn;

  // setting font size value
  set fontSize(double value) {
    _fontSize = value;
    unawaited(_preferences.setFontSize(value));
    notifyListeners();
  }

  // setting is bangla name
  set isBn(bool value) {
    _isBn = value;
    notifyListeners();
  }

  /// setting font family value
  set arabicFontFamily(String value) {
    _arabicFontFamily = value;
    unawaited(_fontFamilyPreferences.setFontSize(value));
    notifyListeners();
  }

  /// getting value from preferences
  Future<void> getPreferences() async {
    _fontSize = await _preferences.getFontSize();
    notifyListeners();
  }

  /// getting value from preferences
  Future<void> getPreferences2() async {
    _arabicFontFamily = await _fontFamilyPreferences.getFontSize();
    notifyListeners();
  }
}
