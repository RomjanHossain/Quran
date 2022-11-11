import 'package:flutter/material.dart';
import 'package:quran/model/translations/lan_and_code.dart';

class MyRightDrawer extends StatelessWidget {
  const MyRightDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // a button to close the drawer
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
          // show languageAndCode map as a list of buttons
          ...languageAndCode.keys
              .map(
                (key) => Text(
                  key,
                  style: const TextStyle(fontSize: 20),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
