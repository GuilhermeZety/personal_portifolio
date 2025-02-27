import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:personal_portifolio/app/core/common/constants/app_constants.dart';
import 'package:personal_portifolio/app/core/shared/current_session.dart';
import 'package:personal_portifolio/app/core/shared/features/prismic/models/content_model.dart';

class PrismicService {
  static Future<String?> getUpdatedRef() async {
    var response = await Dio().get(AppConstants.prismicUrl);

    var refs = List<Map<String, dynamic>>.from(response.data['refs']);

    if (refs.isEmpty) {
      return null;
    }

    var masterRef = refs.where((e) => e['isMasterRef']);

    return masterRef.first['ref'];
  }

  //CACHED

  static Future<List<ContentModel>> getContent() async {
    try {
      final prefs = CurrentSession().prefs;

      final ref = await getUpdatedRef();
      if (ref == null) {
        throw Exception('Erro ao Atualizar a REF da CDN');
      }

      final cachedRef = prefs.getString('prismic-ref');
      if (cachedRef != null) {
        if (cachedRef == ref) {
          var prismicData = prefs.getStringList('prismic-data');

          if (prismicData != null && prismicData.isNotEmpty)
            return prismicData
                .map<ContentModel>((e) => ContentModel.fromJson(e))
                .toList();
        }
      }

      var response = await Dio().get(AppConstants.getFullPrismicUrl(ref));

      log(response.data.toString(), name: 'Prismic');

      await (
        prefs.setString('prismic-ref', ref),
        prefs.setStringList(
          'prismic-data',
          List<Map<String, dynamic>>.from(
            response.data['results'],
          ).map<String>((e) => jsonEncode(e)).toList(),
        ),
      ).wait;

      return response.data['results']
          .map<ContentModel>((e) => ContentModel.fromMap(e))
          .toList();
    } catch (err) {
      rethrow;
    }
  }
}
