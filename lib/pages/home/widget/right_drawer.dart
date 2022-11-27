import "package:flutter/material.dart";
import "package:quran/model/translations/lan_and_code.dart";
import "package:quran/pages/home/components/ff_drop_down.dart";
import "package:quran/pages/home/components/lang_drawer_listview.dart";
import "package:quran/pages/home/widget/fontsize_slider.dart";

/// The right drawer.
class MyRightDrawer extends StatelessWidget {
  /// constractor
  const MyRightDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Drawer(
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
                    label: const Text("Close"),
                  ),
                  //! arabic font size slider
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Arabic Font Size"),
                  ),
                  const FontSizeSlider(),
                  // switch between arabic font family (uthmani/imlaei)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        const Text("Arabic Font Family"),
                        const Spacer(),
                        FontFamilyDropDown(),
                      ],
                    ),
                  ),

                  // show languageAndCode map as a list of buttons
                  ...languageAndCode.keys.map(
                    (String key2) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: TransListInDrawer(
                        key2: key2,
                      ),
                    ),
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
