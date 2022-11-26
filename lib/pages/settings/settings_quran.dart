import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/theme/theme_.dart';
import '../../services/theme/theme_list.dart';

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
        // dark mode switch
        // ListTile(
        //   title: Text('Dark Mode'),
        //   trailing: Switch(
        //     value: true,
        //     onChanged: null,
        //   ),
        // ),

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
        // font size
        const ListTile(
          title: Text('Font Size'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        const Divider(),
        // translation
        const ListTile(
          title: Text('Translation'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        const Divider(),
        // sheikh
        const ListTile(
          title: Text('Sheikh'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        const Divider(),
        // share
        const ListTile(
          title: Text('Share'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        const Divider(),
        // rate
        const ListTile(
          title: Text('Rate'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        const Divider(),
        // about
        const ListTile(
          title: Text('About'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        const Divider(),
        // privacy policy
        const ListTile(
          title: Text('Privacy Policy'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        const Divider(),
        // terms and conditions
        const ListTile(
          title: Text('Terms and Conditions'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        const Divider(),
        // contact us
        const ListTile(
          title: Text('Contact Us'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        const Divider(),
        // exit
        const ListTile(
          title: Text('Exit'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
