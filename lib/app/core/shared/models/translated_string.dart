// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:personal_portifolio/app/core/shared/location_session.dart';
import 'package:signals/signals_flutter.dart';

class TranslatedString {
  final String key;
  final String portuguese;
  final String english;
  final String spanish;

  String translated(BuildContext context) {
    var currentLocale = LocalizationSession().locale.watch(context);
    switch (currentLocale.languageCode) {
      case 'pt':
        return portuguese;
      case 'en':
        return english;
      case 'es':
        return spanish;
      default:
        return portuguese;
    }
  }

  TranslatedString({
    required this.key,
    required this.portuguese,
    required this.english,
    required this.spanish,
  });

  factory TranslatedString.fromMap(Map<String, dynamic> map, String key) {
    String getText(String language) {
      return map['${key}_$language'].first['text'];
    }

    return TranslatedString(
      key: key,
      portuguese: getText('pt'),
      english: getText('en'),
      spanish: getText('es'),
    );
  }
}
