import 'package:flutter/material.dart';
import '../../../model/translations/lan_and_code.dart';
import '../components/ff_drop_down.dart';
import '../components/lang_drawer_listview.dart';
import 'fontsize_slider.dart';

class MyRightDrawer extends StatelessWidget {
  const MyRightDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    label: const Text('Close')),
                //! arabic font size slider
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Arabic Font Size'),
                ),
                const FontSizeSlider(),
                // switch between arabic font family (uthmani/imlaei)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const <Widget>[
                      Text('Arabic Font Family'),
                      Spacer(),
                      FontFamilyDropDown(),
                    ],
                  ),
                ),

                // show languageAndCode map as a list of buttons
                ...languageAndCode.keys.map(
                  (String key2) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TransListInDrawer(
                        key2: key2,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
