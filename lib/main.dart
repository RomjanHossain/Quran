import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:quran/pages/home.dart";
import "package:quran/services/provider/font/font_size_provider.dart";
import "package:quran/services/provider/play/play_provider.dart";
import "package:quran/services/provider/translate/trans_provider.dart";
import "package:quran/services/theme/theme_.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  /// The [MaterialApp] widget is the root of your application.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        // ignore: always_specify_types
        providers: [
          ChangeNotifierProvider<ModelTheme>(
            create: (BuildContext context) => ModelTheme(),
          ),
          ChangeNotifierProvider<TransValProvider>(
            create: (BuildContext context) => TransValProvider(),
          ),
          ChangeNotifierProvider<FontSizeProvider>(
            create: (BuildContext context) => FontSizeProvider(),
          ),
          ChangeNotifierProvider<PlayProvider>(
            create: (BuildContext context) => PlayProvider(),
          ),
        ],
        // create: (BuildContext context) => ModelTheme(),
        child: Consumer<ModelTheme>(
          builder: (
            BuildContext context,
            ModelTheme themeNotifier,
            Widget? child,
          ) =>
              MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Quran Majeed",
            theme: themeNotifier.isDark
                ? ThemeData(
                    brightness: Brightness.dark,
                    useMaterial3: true,
                    colorSchemeSeed: themeNotifier.color,
                  )
                : ThemeData(
                    useMaterial3: true,
                    brightness: Brightness.light,
                    colorSchemeSeed: themeNotifier.color,
                  ),
            home: const MyHomePage(),
          ),
        ),
      );
}
