import "dart:async";

import "package:flutter/material.dart";
import "package:quran/services/provider/translate/trans_pref.dart";

/// trans val prov
class TransValProvider extends ChangeNotifier {
  /// constructor
  TransValProvider() {
    _transList = <String>[];
    _preferences = MyTranslationPreferences();
    unawaited(getPreferences());
  }
  late List<String> _transList;
  late MyTranslationPreferences _preferences;

  /// trans list
  List<String> get transList => _transList;

  // setting font size value
  // set transList(List<String> value) {
  //   _transList = value;
  //   _preferences.setTransVal(value);
  //   notifyListeners();
  // }
  /// add a value to transList
  Future<void> addTransList(String value) async {
    _transList.add(value);
    await _preferences.setTransVal(_transList);
    notifyListeners();
  }

  /// remove a value from transList
  Future<void> removeTransList(String value) async {
    _transList.remove(value);
    await _preferences.setTransVal(_transList);
    notifyListeners();
  }

  /// getting value from preferences
  Future<void> getPreferences() async {
    _transList = await _preferences.getTransVal() ?? <String>[];
    notifyListeners();
  }
}
