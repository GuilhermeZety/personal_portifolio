import 'dart:typed_data';

import 'package:personal_portifolio/app/core/common/constants/app_assets.dart';
import 'package:personal_portifolio/app/core/common/utils/utils.dart';

class SessionMemory {
  //SingleTon
  SessionMemory._();
  static final SessionMemory _instance = SessionMemory._();
  factory SessionMemory() => SessionMemory._instance;
  //

  Future load() async {
    var [brazil, unitedStates, spain] = await Future.wait([
      Utils.getAssetsBytes(AppAssets.svgs.brazil),
      Utils.getAssetsBytes(AppAssets.svgs.unitedStates),
      Utils.getAssetsBytes(AppAssets.svgs.spain),
    ]);
    brazilSVG = brazil;
    unitedStatesSVG = unitedStates;
    spainSVG = spain;
  }

  late Uint8List brazilSVG;
  late Uint8List unitedStatesSVG;
  late Uint8List spainSVG;
}
