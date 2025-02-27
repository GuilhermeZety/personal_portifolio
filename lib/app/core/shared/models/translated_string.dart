// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:personal_portifolio/app/core/shared/location_session.dart';
import 'package:signals/signals_flutter.dart';

class TranslatedString {
  final String key;
  final String portuguese;
  final List<(int indexInicio, int indexFim)> portugueseHighlight;
  final String english;
  final List<(int indexInicio, int indexFim)> englishHighlight;
  final String spanish;
  final List<(int indexInicio, int indexFim)> spanishHighlight;

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

  List<(int, int)> translatedHighlight(BuildContext context) {
    var currentLocale = LocalizationSession().locale.watch(context);
    switch (currentLocale.languageCode) {
      case 'pt':
        return portugueseHighlight;
      case 'en':
        return englishHighlight;
      case 'es':
        return spanishHighlight;
      default:
        return portugueseHighlight;
    }
  }

  TranslatedString({
    required this.key,
    required this.portuguese,
    this.portugueseHighlight = const [],
    required this.english,
    this.englishHighlight = const [],
    required this.spanish,
    this.spanishHighlight = const [],
  });

  factory TranslatedString.fromMap(
    Map<String, dynamic> map,
    String key,
    bool withHighlight,
  ) {
    String getText(String language) {
      return map['${key}_$language'].first['text'];
    }

    List<(int, int)> getHighlight(String language) {
      if (withHighlight) {
        var item = map['${key}_$language'].first;
        return List<Map<String, dynamic>>.from(
          item['spans'],
        ).map((e) => (e['start'] as int, e['end'] as int)).toList();
      }
      return [];
    }

    return TranslatedString(
      key: key,
      portuguese: getText('pt'),
      portugueseHighlight: getHighlight('pt'),
      english: getText('en'),
      englishHighlight: getHighlight('en'),
      spanish: getText('es'),
      spanishHighlight: getHighlight('es'),
    );
  }
}
