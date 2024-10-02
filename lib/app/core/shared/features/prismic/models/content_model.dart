// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:personal_portifolio/app/core/shared/features/prismic/data_types.dart';
import 'package:personal_portifolio/app/core/shared/models/translated_string.dart';

class ContentModel extends Equatable {
  final String uuid;

  const ContentModel({
    required this.uuid,
  });

  factory ContentModel.fromMap(Map<String, dynamic> map) {
    log(map.toString());
    if (map['type'] == 'sobre_mim') {
      return AboutMeContentModel.fromMap(map);
    }

    return ContentModel(
      uuid: map['uid'],
    );
  }

  factory ContentModel.fromJson(String source) => AboutMeContentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        uuid,
      ];
}

class AboutMeContentModel extends ContentModel {
  final String image;
  final TranslatedString title;
  final TranslatedString subtitle;
  final TranslatedString description;
  final String curriculumLink;
  final String emailLink;
  final DataTypes type;

  const AboutMeContentModel({
    required super.uuid,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.curriculumLink,
    required this.emailLink,
  }) : type = DataTypes.apresentation;

  AboutMeContentModel copyWith({
    String? uuid,
    String? image,
    TranslatedString? title,
    TranslatedString? subtitle,
    TranslatedString? description,
    String? curriculumLink,
    String? emailLink,
  }) {
    return AboutMeContentModel(
      uuid: uuid ?? this.uuid,
      image: image ?? this.image,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      curriculumLink: curriculumLink ?? this.curriculumLink,
      emailLink: emailLink ?? this.emailLink,
    );
  }

  factory AboutMeContentModel.fromMap(Map<String, dynamic> map) {
    return AboutMeContentModel(
      uuid: map['uid'],
      image: map['data']['foto']['url'],
      title: TranslatedString.fromMap(
        map['data']['titulo'].first as Map<String, dynamic>,
        'title',
        false,
      ),
      subtitle: TranslatedString.fromMap(
        map['data']['subtitle'].first as Map<String, dynamic>,
        'subtitle',
        false,
      ),
      description: TranslatedString.fromMap(
        map['data']['description'].first as Map<String, dynamic>,
        'description',
        true,
      ),
      curriculumLink: map['data']['curriculum']['url'],
      emailLink: map['data']['email']['url'],
    );
  }

  factory AboutMeContentModel.fromJson(String source) => AboutMeContentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<String?> get props => [uuid, image, curriculumLink, emailLink];
}
