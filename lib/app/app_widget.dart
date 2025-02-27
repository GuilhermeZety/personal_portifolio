import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:personal_portifolio/app/core/common/constants/app_theme.dart';
import 'package:personal_portifolio/app/core/shared/location_session.dart';
import 'package:personal_portifolio/app/modules/splash/presentation/pages/splash_page.dart';
import 'package:signals/signals_flutter.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String translationsPath = 'translations';
    if (!kDebugMode) {
      translationsPath = 'assets/$translationsPath';
    }
    LocalJsonLocalization.delegate.directories = [translationsPath];

    return ThemeProvider(
      initTheme:
          AppTheme().themeMode.value == ThemeMode.dark ? AppTheme.dark : AppTheme.light,
      builder: (context, myTheme) {
        return MaterialApp(
          title: 'Portifolio | Guilherme Martins',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            LocalJsonLocalization.delegate,
          ],
          supportedLocales: LocalizationSession().suportedLocales.map(
            (e) => Locale(e.$1, e.$2),
          ),
          locale: LocalizationSession().locale.watch(context),
          theme: myTheme,
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
        );
      },
    );
  }
}
