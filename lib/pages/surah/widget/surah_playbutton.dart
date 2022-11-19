import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/provider/play/play_provider.dart';

class CenterButtonWidget extends StatefulWidget {
  const CenterButtonWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  State<CenterButtonWidget> createState() => _CenterButtonWidgetState();
}

class _CenterButtonWidgetState extends State<CenterButtonWidget> {
  // final AudioPlayer player = AudioPlayer(); // Create a player
  bool _isPressed = false;

  @override
  void initState() {
    _isPressed =
        Provider.of<PlayProvider>(context, listen: false).player.playing;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // check if the player is playing

    return Consumer<PlayProvider>(builder:
        (BuildContext context, PlayProvider playProvider, Widget? child) {
      // check if playProvider.playName is changed
      if (playProvider.player.playing) {
        _isPressed = true;
      } else {
        _isPressed = false;
      }

      // print(playProvider.playName);
      // print('url is $url');
      return FloatingActionButton.large(
        onPressed: () async {
          if (_isPressed) {
            // player.pause();
            playProvider.player.pause();
            setState(() {
              _isPressed = false;
            });
          } else {
            print('play btn clicked');
            playProvider.player.play();
            print(playProvider.player.playing);
            // player.play();
            setState(() {
              _isPressed = true;
            });
          }
        },

        backgroundColor: Colors.indigo,
        // tooltip: 'long press to change the reciter',
        child:
            _isPressed ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
      );
    });
  }
}
