import 'package:flutter/material.dart';
import '../../../model/translations/lan_and_code.dart';
import '../../../model/translations/translations.dart';
import '../components/lang_drawer_listview.dart';
import 'fontsize_slider.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text('Configurations'),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),

          //! arabic font size slider
          const Text('Arabic Font Size'),
          const FontSizeSlider(),
          // switch between arabic font family (uthmani/imlaei)

          // show languageAndCode map as a list of buttons
          ...languageAndCode.keys.map(
            (String key) {
              return AllLangDrawerListView(
                key2: key,
              );
            },
          ),
        ],
      ),
    );
  }
}
