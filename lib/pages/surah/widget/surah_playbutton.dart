import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:connectivity_plus/connectivity_plus.dart";
import "package:quran/services/provider/play/play_provider.dart";

/// center play button
class CenterButtonWidget extends StatefulWidget {
  /// constractor
  const CenterButtonWidget({
    required this.index,
    super.key,
  });

  /// surah index
  // ignore: diagnostic_describe_all_properties
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
  Widget build(BuildContext context) => Consumer<PlayProvider>(
        builder:
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
// check if the device is connected to the internet
              final ConnectivityResult result =
                  await Connectivity().checkConnectivity();
              if (result == ConnectivityResult.none) {
                // show a dialog to the user
                // ignore: use_build_context_synchronously
                await showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text("No Internet Connection"),
                    content: const Text(
                        "Please check your internet connection and try again"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              } else {
                if (_isPressed) {
                  // player.pause();
                  await playProvider.player.pause();
                  setState(() {
                    _isPressed = false;
                  });
                } else {
                  // print('play btn clicked');
                  await playProvider.player.play();
                  // print(playProvider.player.playing);
                  // player.play();
                  setState(() {
                    _isPressed = true;
                  });
                }
              }
            },

            backgroundColor: Theme.of(context).primaryColor,
            // tooltip: 'long press to change the reciter',
            child: _isPressed
                ? const Icon(Icons.pause)
                : const Icon(Icons.play_arrow),
          );
        },
      );
}
