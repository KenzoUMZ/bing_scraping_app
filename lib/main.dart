import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

import 'core/core.dart';
import 'core/global/base/module/env/dev_env.dart';
import 'core/global/modules/search/search_module.dart';
import 'layers/presentation_layer/presentation_layer.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      LocalJsonLocalization.delegate.directories = ['lib/i18n/'];

      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

      SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
        Future.delayed(const Duration(seconds: 2), () {
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
            ),
          );
        });
      });

      runApp(
        ModularApp(
          modules: [CoreModule(), SearchModule()],
          devEnv: DevEnv(),
          child: const MyApp(),
        ),
      );
      // ignore: require_trailing_commas
    },
    (error, stack) {
      if (kDebugMode) {
        print('Caught error: $error');
        print('Stack trace: $stack');
      }
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) {
        return KeyboardDismissOnTap(
          child: SafeArea(
            top: false,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Delivery App',
              theme: AppTheme.light(),
              initialRoute: Routes.splash,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                LocalJsonLocalization.delegate,
              ],
              supportedLocales: const [Locale('pt', 'BR')],
              localeResolutionCallback: (locale, supportedLocales) {
                if (supportedLocales.contains(locale)) {
                  return locale;
                }

                return const Locale('pt', 'BR');
              },
              navigatorKey: NavigatorSingleton.I.navigatorKey,
              onGenerateRoute: (settings) {
                return switch (settings.name) {
                  Routes.splash => MaterialPageRoute(
                    builder: (_) => const SplashPage(),
                  ),
                  Routes.search => MaterialPageRoute(
                    builder: (_) => const SearchPage(),
                  ),
                  Routes.results => MaterialPageRoute(
                    builder: (_) => const ResultsPage(),
                  ),
                  _ => MaterialPageRoute(
                    builder: (_) => Text(settings.name ?? ''),
                  ),
                };
              },
            ),
          ),
        );
      },
    );
  }
}
