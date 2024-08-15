import 'dart:io';
import 'dart:ui';

import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';

class LocalizatiionSession {
  //SingleTon
  LocalizatiionSession._();
  static final LocalizatiionSession _instance = LocalizatiionSession._();
  factory LocalizatiionSession() => LocalizatiionSession._instance;
  //

  late Signal<Locale> locale;

  void init() {
    // locale = Locale(session.prefs.getString('localization') ?? Platform.localeName.split('_')[0]).toSignal();
    locale = Locale(Platform.localeName.split('_')[0]).toSignal();
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
    // session.prefs.setString('localization', locale.value.languageCode.substring(0, 2));
  }
}
