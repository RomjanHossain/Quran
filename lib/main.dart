import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home.dart';
import 'services/provider/font/font_size_provider.dart';
import 'services/provider/play/play_provider.dart';
import 'services/provider/translate/trans_provider.dart';
import 'services/theme/theme_.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // ignore: always_specify_types
      providers: [
        ChangeNotifierProvider<ModelTheme>(
            create: (BuildContext context) => ModelTheme()),
        ChangeNotifierProvider<TransValProvider>(
            create: (BuildContext context) => TransValProvider()),
        ChangeNotifierProvider<FontSizeProvider>(
            create: (BuildContext context) => FontSizeProvider()),
        ChangeNotifierProvider<PlayProvider>(
            create: (BuildContext context) => PlayProvider()),
      ],
      // create: (BuildContext context) => ModelTheme(),
      child: Consumer<ModelTheme>(builder:
          (BuildContext context, ModelTheme themeNotifier, Widget? child) {
        return MaterialApp(
          title: 'Quran Majeed',
          theme: themeNotifier.isDark
              ? ThemeData(
                  brightness: Brightness.dark,
                  useMaterial3: true,
                  // primarySwatch: Colors.lightGreen,

                  // scaffoldBackgroundColor: const Color(0xff171813),
                  // scaffoldBackgroundColor: Colors.yellow,
                  // primaryColor: Colors.green,

                  // colorScheme: ColorScheme.fromSwatch(),
                )
              : ThemeData(
                  useMaterial3: true,
                  brightness: Brightness.light,
                  // primarySwatch: Colors.pink,
                  // primaryColor: Colors.green,
                  // primarySwatch: Colors.green,
                ),
          home: const MyHomePage(),
        );
      }),
    );
  }
}
