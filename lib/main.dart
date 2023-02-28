import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musify/screens/more_page.dart';
import 'package:musify/screens/root_page.dart';
import 'package:musify/services/audio_manager.dart';
import 'package:musify/style/app_colors.dart';
import 'package:musify/style/app_themes.dart';

GetIt getIt = GetIt.instance;
bool _interrupted = false;
ThemeMode themeMode = ThemeMode.system;

final appLanguages = <String, String>{
  'English': 'en',
  'Georgian': 'ka',
  'Chinese': 'zh',
  'Traditional Chinese Taiwan': 'zh_TW',
  'Dutch': 'nl',
  'German': 'de',
  'Indonesian': 'id',
  'Italian': 'it',
  'Polish': 'pl',
  'Portuguese': 'pt',
  'Spanish': 'es',
  'Turkish': 'tr',
  'Ukrainian': 'uk',
  'Russian': 'ru',
};

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static Future<void> setThemeMode(
    BuildContext context,
    ThemeMode newThemeMode,
  ) async {
    final state = context.findAncestorStateOfType<_MyAppState>()!;
    state.changeTheme(newThemeMode);
  }

  static Future<void> setLocale(
    BuildContext context,
    Locale newLocale,
  ) async {
    final state = context.findAncestorStateOfType<_MyAppState>()!;
    state.changeLanguage(newLocale);
  }

  static Future<void> setAccentColor(
    BuildContext context,
    Color newAccentColor,
    bool systemColorStatus,
  ) async {
    final state = context.findAncestorStateOfType<_MyAppState>()!;
    state.changeAccentColor(newAccentColor, systemColorStatus);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', '');

  void changeTheme(ThemeMode newThemeMode) {
    setState(() {
      themeMode = newThemeMode;
    });
  }

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void changeAccentColor(Color newAccentColor, bool systemColorStatus) {
    setState(() {
      useSystemColor.value = systemColorStatus;
      accent = ColorScheme.fromSwatch(
        primarySwatch: getMaterialColorFromColor(
          newAccentColor,
        ),
        accentColor: newAccentColor,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    final settingsBox = Hive.box('settings');

    final language =
        settingsBox.get('language', defaultValue: 'English') as String;
    _locale = Locale(appLanguages[language] ?? 'en');

    final themeModeSetting =
        settingsBox.get('themeMode', defaultValue: 'system') as String;
    themeMode = themeModeSetting == 'system'
        ? ThemeMode.system
        : themeModeSetting == 'light'
            ? ThemeMode.light
            : ThemeMode.dark;
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        if (lightColorScheme != null ||
            darkColorScheme != null && useSystemColor.value == true) {
          accent = (themeMode == ThemeMode.light
              ? lightColorScheme
              : darkColorScheme)!;
        }
        return MaterialApp(
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          darkTheme: darkColorScheme != null && useSystemColor.value == true
              ? getAppDarkTheme().copyWith(
                  scaffoldBackgroundColor: darkColorScheme.surface,
                  colorScheme: darkColorScheme.harmonized(),
                  canvasColor: darkColorScheme.surface,
                  bottomAppBarTheme:
                      BottomAppBarTheme(color: darkColorScheme.surface),
                  appBarTheme: AppBarTheme(
                    backgroundColor: darkColorScheme.surface,
                    centerTitle: true,
                    titleTextStyle: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                      color: accent.primary,
                    ),
                    elevation: 0,
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
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
                )
              : getAppDarkTheme(),
          theme: lightColorScheme != null && useSystemColor.value == true
              ? getAppLightTheme().copyWith(
                  scaffoldBackgroundColor: lightColorScheme.surface,
                  colorScheme: lightColorScheme.harmonized(),
                  canvasColor: lightColorScheme.surface,
                  bottomAppBarTheme:
                      BottomAppBarTheme(color: lightColorScheme.surface),
                  appBarTheme: AppBarTheme(
                    backgroundColor: lightColorScheme.surface,
                    centerTitle: true,
                    titleTextStyle: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                      color: accent.primary,
                    ),
                    elevation: 0,
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
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
                )
              : getAppLightTheme(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('ka', ''),
            Locale.fromSubtags(languageCode: 'zh'),
            Locale.fromSubtags(
              languageCode: 'zh',
              scriptCode: 'Hant',
              countryCode: 'TW',
            ),
            Locale('nl', ''),
            Locale('fr', ''),
            Locale('de', ''),
            Locale('he', ''),
            Locale('hi', ''),
            Locale('hu', ''),
            Locale('id', ''),
            Locale('it', ''),
            Locale('pl', ''),
            Locale('pt', ''),
            Locale('es', ''),
            Locale('ta', ''),
            Locale('tr', ''),
            Locale('uk', ''),
            Locale('ur', ''),
            Locale('ru', '')
          ],
          locale: _locale,
          home: Musify(),
        );
      },
    );
  }
}

void main() async {
  await initialisation();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

Future<void> initialisation() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Hive.openBox('user');
  await Hive.openBox('cache');

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.gokadzev.musify',
    androidNotificationChannelName: 'Musify',
    androidNotificationIcon: 'mipmap/launcher_icon',
    androidShowNotificationBadge: true,
    androidStopForegroundOnPause: !foregroundService.value,
  );

  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.music());
  session.interruptionEventStream.listen((event) {
    if (event.begin) {
      if (audioPlayer.playing) {
        audioPlayer.pause();
        _interrupted = true;
      }
    } else {
      switch (event.type) {
        case AudioInterruptionType.pause:
        case AudioInterruptionType.duck:
          if (!audioPlayer.playing && _interrupted) {
            audioPlayer.play();
          }
          break;
        case AudioInterruptionType.unknown:
          break;
      }
      _interrupted = false;
    }
  });
  activateListeners();
  await enableBooster();

  try {
    await FlutterDownloader.initialize(
      debug: kDebugMode,
      ignoreSsl: true,
    );

    await FlutterDownloader.registerCallback(downloadCallback);
  } catch (e) {
    debugPrint('error while initializing Flutter Downloader plugin $e');
  }
}

@pragma('vm:entry-point')
void downloadCallback(String id, DownloadTaskStatus status, int progress) {}
