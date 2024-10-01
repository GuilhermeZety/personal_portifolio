import 'package:dio/dio.dart';
import 'package:personal_portifolio/app/core/common/constants/app_constants.dart';
import 'package:personal_portifolio/app/core/shared/features/prismic/data_types.dart';

class PrismicService {
  static Future<List<Map<String, dynamic>>> getByType(DataTypes type) async {
    var response = await Dio().get('${AppConstants.getFullPrismicUrl}&q=[[at(document.type, ${type.toPrismicName()})]]');
    return [];
  }
}
