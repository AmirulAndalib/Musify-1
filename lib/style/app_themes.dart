import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ColorScheme accent = ColorScheme.fromSeed(
  seedColor:
      Color(Hive.box('settings').get('accentColor', defaultValue: 0xFFF08080)),
);

ThemeData getAppDarkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xFF121212),
    canvasColor: const Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF121212),
      iconTheme: IconThemeData(color: accent.primary),
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.w700,
        color: accent.primary,
      ),
      elevation: 0,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF121212),
    ),
    colorScheme: accent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Ubuntu',
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF151515),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2.3,
    ),
    listTileTheme: ListTileThemeData(textColor: accent.primary),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all(accent.primary),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    hintColor: Colors.white,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF151515)),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: accent.background.withAlpha(50),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.only(
        left: 18,
        right: 20,
        top: 14,
        bottom: 14,
      ),
    ),
  );
}

ThemeData getAppLightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    colorScheme: accent,
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: accent.primary),
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.w700,
        color: accent.primary,
      ),
      elevation: 0,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Ubuntu',
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2.3,
    ),
    listTileTheme: ListTileThemeData(
      selectedColor: accent.primary.withOpacity(0.4),
      textColor: accent.primary,
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all(accent.primary),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF151515)),
    hintColor: const Color(0xFF151515),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: accent.background.withAlpha(50),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.only(
        left: 18,
        right: 20,
        top: 14,
        bottom: 14,
      ),
    ),
  );
}
