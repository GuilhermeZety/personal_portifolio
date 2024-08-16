import 'package:personal_portifolio/app/core/common/constants/app_theme.dart';
import 'package:personal_portifolio/app/core/shared/location_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentSession {
  //SingleTon
  CurrentSession._();
  static final CurrentSession _instance = CurrentSession._();
  factory CurrentSession() => CurrentSession._instance;
  //

  late SharedPreferences prefs;

  void init() async {
    await SharedPreferences.getInstance().then((pref) => prefs = pref);
    LocalizationSession().init();
    AppTheme().init();
  }
}
