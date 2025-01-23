import 'dart:ui';

import 'package:personal_portifolio/app/core/shared/current_session.dart';
import 'package:signals/signals_flutter.dart';

class LocalizationSession {
  //SingleTon
  LocalizationSession._();
  static final LocalizationSession _instance = LocalizationSession._();
  factory LocalizationSession() => LocalizationSession._instance;
  //

  late Signal<Locale> locale;

  void init() {
    locale = signal(
      Locale(
        CurrentSession().prefs.getString('localization') ?? PlatformDispatcher.instance.locale.languageCode,
      ),
      debugLabel: 'LOCALIZATION',
    );
  }

  final List<(String, String)> suportedLocales = [
    ('en', 'US'),
    ('pt', 'BR'),
    ('es', 'ES'),
  ];

  void switchLocale() {
    switch (locale.value.languageCode) {
      case 'pt':
        locale.value = const Locale('en', 'US');
        break;
      case 'en':
        locale.value = const Locale('es', 'ES');
        break;
      case 'es':
        locale.value = const Locale('pt', 'BR');
        break;
    }
    CurrentSession().prefs.setString('localization', locale.value.languageCode.substring(0, 2));
  }
}
