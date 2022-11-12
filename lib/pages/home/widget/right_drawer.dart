import 'package:flutter/material.dart';
import '../../../model/translations/lan_and_code.dart';

class MyRightDrawer extends StatelessWidget {
  const MyRightDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // a button to close the drawer
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
          // show languageAndCode map as a list of buttons
          ...languageAndCode.keys.map(
            (String key) => Text(
              key,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
