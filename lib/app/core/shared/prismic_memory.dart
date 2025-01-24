import 'dart:developer';

import 'package:personal_portifolio/app/core/shared/features/prismic/models/contact_model.dart';
import 'package:personal_portifolio/app/core/shared/features/prismic/models/content_model.dart';
import 'package:personal_portifolio/app/core/shared/features/prismic/prismic_service.dart';

class PrismicMemory {
  //SingleTon
  PrismicMemory._();
  static final PrismicMemory _instance = PrismicMemory._();
  factory PrismicMemory() => PrismicMemory._instance;
  //

  AboutMeContentModel? aboutMe;
  ContactContentModel? contact;

  Future load() async {
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await PrismicService.getContent();

    if (response.isNotEmpty) {
      aboutMe = response.whereType<AboutMeContentModel>().first;
      contact = response.whereType<ContactContentModel>().first;

      stopwatch.stop();
      log('Prismic carregado em ${stopwatch.elapsedMilliseconds}ms', name: 'Prismic');
    }
  }
}
