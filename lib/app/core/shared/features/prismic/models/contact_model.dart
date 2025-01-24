// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:personal_portifolio/app/core/shared/features/prismic/models/content_model.dart';

class ContactContentModel extends ContentModel {
  final List<ContactItemContentModel> items;

  const ContactContentModel({
    required super.uuid,
    required this.items,
  });

  ContactContentModel copyWith({
    String? uuid,
    List<ContactItemContentModel>? items,
  }) {
    return ContactContentModel(
      uuid: uuid ?? this.uuid,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory ContactContentModel.fromMap(Map<String, dynamic> map) {
    return ContactContentModel(
      items: map['data']['contact_itens']
          .map<ContactItemContentModel>(
            (x) => ContactItemContentModel.fromMap(x as Map<String, dynamic>),
          )
          .toList(),
      uuid: map['uuid'] ?? 'uuid',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactContentModel.fromJson(String source) => ContactContentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ContactContentModel(items: $items)';
}

class ContactItemContentModel extends Equatable {
  final String icon;
  final String title;
  final String description;
  final String link;
  final Color color;

  const ContactItemContentModel({
    required this.icon,
    required this.title,
    required this.description,
    required this.link,
    required this.color,
  });

  ContactItemContentModel copyWith({
    String? icon,
    String? title,
    String? description,
    String? link,
    Color? color,
  }) {
    return ContactItemContentModel(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      description: description ?? this.description,
      link: link ?? this.link,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'icon': icon,
      'title': title,
      'description': description,
      'link': link,
    };
  }

  factory ContactItemContentModel.fromMap(Map<String, dynamic> map) {
    var color = (map['color'] as String).replaceAll('#', '');
    color = '0xFF$color';

    return ContactItemContentModel(
      icon: map['icon']['url'] as String,
      title: map['title'].first['text'] as String,
      description: map['description'].first['text'] as String,
      link: map['link']['url'] as String,
      color: Color(int.parse(color)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactItemContentModel.fromJson(String source) => ContactItemContentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [icon, title, description, link];
}
