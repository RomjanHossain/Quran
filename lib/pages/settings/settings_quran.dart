import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../services/theme/theme_.dart';
import '../../services/theme/theme_list.dart';
import '../home/widget/fontsize_slider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  String _getColor(Color col) {
    final String _key = allColors.keys.firstWhere(
        (String _key) => allColors[_key] == col,
        orElse: () => 'Blue');
    return _key;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        // big setting icon
        Icon(
          Icons.settings,
          size: 100,
          color: Theme.of(context).colorScheme.primary,
        ),
        Consumer<ModelTheme>(
            builder: (BuildContext context, ModelTheme value, Widget? child) {
          return ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
                value: value.isDark,
                onChanged: (bool b) {
                  value.isDark = b;
                }),
          );
        }),
        const Divider(),
        // font size
        Consumer<ModelTheme>(
            builder: (BuildContext context, ModelTheme value, Widget? child) {
          return ListTile(
            title: const Text('Color Scheme'),
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
              itemBuilder: (BuildContext context) {
                // return allColors as List<PopupMenuEntry<Color>>;
                return allColors.entries.map((MapEntry<String, Color> entry) {
                  return PopupMenuItem<Color>(
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
                  );
                }).toList();
              },
            ),
          );
        }),
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
              'Font Size',
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
          title: Text('Privacy Policy'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            // open a bottom sheet
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Privacy Policy',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "This app collects no private data, period. Your data will not be used in any way, because we won't have it.",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      )
                    ],
                  );
                });
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
            onPressed: () {
              // SystemNavigator.pop();
              // show a dialog to confirm exit
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Exit'),
                    content: const Text('Are you sure you want to exit?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Exit'),
          ),
        ),
      ],
    );
  }
}
