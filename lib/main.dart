import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/pages/home.dart';
import 'package:quran/services/theme/theme_.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
        return MaterialApp(
          title: 'Quran Majeed',
          theme: themeNotifier.isDark
              ? ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.blue,
                )
              : ThemeData(
                  brightness: Brightness.light,
                  primaryColor: Colors.green,
                  primarySwatch: Colors.green),
          home: const MyHomePage(),
        );
      }),
    );
  }
}
