// ignore_for_file: lines_longer_than_80_chars

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";
import "package:quran/pages/home/widget/fontsize_slider.dart";
import "package:quran/services/theme/theme_.dart";
import "package:quran/services/theme/theme_list.dart";

/// settings
class Settings extends StatelessWidget {
  /// constractor
  const Settings({super.key});

  String _getColor(Color col) {
    // ignore: no_leading_underscores_for_local_identifiers
    final String _key = allColors.keys.firstWhere(
      // ignore: no_leading_underscores_for_local_identifiers
      (String _key) => allColors[_key] == col,
      orElse: () => "Blue",
    );
    return _key;
  }

  @override
  Widget build(BuildContext context) => ListView(
        children: <Widget>[
          // big setting icon
          Icon(
            Icons.settings,
            size: 100,
            color: Theme.of(context).colorScheme.primary,
          ),
          Consumer<ModelTheme>(
            builder: (BuildContext context, ModelTheme value, Widget? child) =>
                ListTile(
              title: const Text("Dark Mode"),
              trailing: Switch(
                value: value.isDark,
                onChanged: (bool b) {
                  value.isDark = b;
                },
              ),
            ),
          ),
          const Divider(),
          // font size
          Consumer<ModelTheme>(
            builder: (BuildContext context, ModelTheme value, Widget? child) =>
                ListTile(
              title: const Text("Color Scheme"),
              // trailing a popup menu for all color schemes
              trailing: PopupMenuButton<Color>(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(_getColor(value.color)),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.color_lens, color: value.color),
                  ],
                ),
                onSelected: (Color col) {
                  value.color = col;
                },
                itemBuilder: (BuildContext context) => allColors.entries
                    .map(
                      (MapEntry<String, Color> entry) => PopupMenuItem<Color>(
                        value: entry.value,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(entry.key),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.color_lens, color: entry.value),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const Divider(),
          // font size with a slider
          // ListTile(
          //   title: const Text('Font Size'),
          //   trailing: FontSizeSlider(),
          // ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                "Font Size",
                // textAlign: TextAlign.left,
              ),
              FontSizeSlider(),
            ],
          ),

          // translation
          // const ListTile(
          //   title: Text('Translation'),
          // ),

          // ...languageAndCode.keys.map(
          //   (String key2) {
          //     return Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: TransListInDrawer(
          //         key2: key2,
          //       ),
          //     );
          //   },
          // ),

          const Divider(),
          // privacy policy
          ListTile(
            title: const Text("Privacy Policy"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () async {
              // open a bottom sheet
              await showModalBottomSheet(
                context: context,
                builder: (BuildContext context) => Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Privacy Policy",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "This app collects no private data, period. Your data will not be used in any way, because we won't have it.",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          const Divider(),

          // const Divider(),
          // contact us
          // const ListTile(
          //   title: Text('Contact Us'),
          //   trailing: Icon(Icons.arrow_forward_ios),
          // ),
          // a button to exit the app
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text("Exit"),
                    content: const Text("Are you sure you want to exit?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("No"),
                      ),
                      const TextButton(
                        onPressed: SystemNavigator.pop,
                        child: Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("Exit"),
            ),
          ),
        ],
      );
}
