import "dart:async";

import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";
import "package:quran/pages/surah/utils/geturl.dart";
import "package:quran/services/provider/play/play_pref.dart";

/// play prov
class PlayProvider extends ChangeNotifier {
  /// constructor
  PlayProvider() {
    _playName = "";
    _playIndex = 0;
    _preferences = MyPlayPreferences();
    unawaited(getPreferences());
  }

  /// player
  final AudioPlayer player = AudioPlayer(); // Create a player

  late String _playName;
  late int _playIndex;
  late MyPlayPreferences _preferences;

  /// play name
  String get playName => _playName;

  /// add a value to transList
  Future<void> addPlayer(String value) async {
    // print('adding player -> $value');
    _playName = value;
    await player.setUrl(value);
    await _preferences.setPlayVal(_playName);
    notifyListeners();
  }

  /// set play index
  void setPlayIndex(int index) {
    _playIndex = index;
    notifyListeners();
  }

  /// set player url
  Future<void> setPlayerUrl() async {
    final String name =
        _playName.isEmpty ? "Abdul-Rahman Al-Sudais" : _playName;
    // ignore: no_leading_underscores_for_local_identifiers
    final String _url = getTheUrlOfCurrentIndexAndSheikh(name, _playIndex);
    await player.setUrl(_url);
    notifyListeners();
  }

  /// getting value from preferences
  Future<void> getPreferences() async {
    _playName = await _preferences.getPlayVal() ?? "";
    notifyListeners();
  }
}
