import 'package:flutter/material.dart';

class CenterButtonWidget extends StatefulWidget {
  const CenterButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CenterButtonWidget> createState() => _CenterButtonWidgetState();
}

class _CenterButtonWidgetState extends State<CenterButtonWidget> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(
      onPressed: () {
        print('just pressed');
        setState(() {
          _isPressed = !_isPressed;
        });
      },
      backgroundColor: Colors.indigo,
      // tooltip: 'long press to change the reciter',
      child:
          _isPressed ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
    );
  }
}
