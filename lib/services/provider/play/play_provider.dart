import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../../pages/surah/utils/geturl.dart';
import 'play_pref.dart';

class PlayProvider extends ChangeNotifier {
  PlayProvider() {
    _playName = '';
    _playIndex = 0;
    _preferences = MyPlayPreferences();
    getPreferences();
  }
  final AudioPlayer player = AudioPlayer(); // Create a player

  late String _playName;
  late int _playIndex;
  late MyPlayPreferences _preferences;
  String get playName => _playName;

  // add a value to transList
  void addPlayer(String value) {
    // print('adding player -> $value');
    _playName = value;
    player.setUrl(value);
    _preferences.setPlayVal(_playName);
    notifyListeners();
  }

  void setPlayIndex(int index) {
    _playIndex = index;
    notifyListeners();
  }

  void setPlayerUrl() {
    final String name =
        _playName.isEmpty ? 'Abdul-Rahman Al-Sudais' : _playName;
    // ignore: no_leading_underscores_for_local_identifiers
    final String _url = getTheUrlOfCurrentIndexAndSheikh(name, _playIndex);
    player.setUrl(_url);
    notifyListeners();
  }

  // getting value from preferences
  Future<void> getPreferences() async {
    _playName = await _preferences.getPlayVal() ?? '';
    notifyListeners();
  }
}
