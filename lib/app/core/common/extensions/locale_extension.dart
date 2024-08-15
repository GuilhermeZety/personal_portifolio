import 'package:localization/localization.dart';

extension LocaleExtension on String {
  String get t => i18n();

  String translate(List<String> args) => i18n(args);
}
