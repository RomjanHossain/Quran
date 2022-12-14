import "package:flutter/material.dart";

import "package:quran/pages/real_home.dart";
import "package:quran/pages/settings/settings_quran.dart";

/// The home page of the app.
class MyHomePage extends StatefulWidget {
  /// constractor
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // two pages
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    SurahListView(),
    Settings(),
  ];
  static const List<Widget> _title = <Widget>[
    Text("Al-Quran"),
    Text("Settings"),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: _title.elementAt(_selectedIndex),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: NavigationBar(
          // backgroundColor: Theme.of(context).primaryColor,
          // surfaceTintColor: Theme.of(context).primaryColor,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int value) => setState(
            () {
              _selectedIndex = value;
            },
          ),
          // navigation transparency
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      );
}
