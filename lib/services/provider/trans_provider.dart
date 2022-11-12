import 'package:flutter/material.dart';
import 'trans_pref.dart';

class TransValProvider extends ChangeNotifier {
  TransValProvider() {
    _transList = <String>[];
    _preferences = MyTranslationPreferences();
    getPreferences();
  }
  late List<String> _transList;
  late MyTranslationPreferences _preferences;
  List<String> get transList => _transList;

  // setting font size value
  set transList(List<String> value) {
    _transList = value;
    _preferences.setTransVal(value);
    notifyListeners();
  }

  // getting value from preferences
  Future<void> getPreferences() async {
    _transList = await _preferences.getTransVal() ?? <String>[];
    notifyListeners();
  }
}
