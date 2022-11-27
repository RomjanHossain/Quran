import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home.dart';
import 'services/provider/font/font_size_provider.dart';
import 'services/provider/play/play_provider.dart';
import 'services/provider/translate/trans_provider.dart';
import 'services/theme/theme_.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
                  // primaryColor: themeNotifier.color,
                  // primarySwatch: MaterialColor(themeNotifier.color.value, {
                  //   50: themeNotifier.color,
                  //   100: themeNotifier.color,
                  //   200: themeNotifier.color,
                  //   300: themeNotifier.color,
                  //   400: themeNotifier.color,
                  //   500: themeNotifier.color,
                  //   600: themeNotifier.color,
                  //   700: themeNotifier.color,
                  //   800: themeNotifier.color,
                  //   900: themeNotifier.color,
                  // }),
                  // backgroundColor: themeNotifier.color,
                  // button color
                  colorSchemeSeed: themeNotifier.color,

                  // scaffoldBackgroundColor: themeNotifier.color.withOpacity(0.2),
                )
              : ThemeData(
                  useMaterial3: true,
                  brightness: Brightness.light,
                  colorSchemeSeed: themeNotifier.color,

                  // scaffoldBackgroundColor: themeNotifier.color.withOpacity(0.2),
                ),
          home: const MyHomePage(),
        );
      }),
    );
  }
}
