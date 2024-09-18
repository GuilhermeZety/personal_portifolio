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
    var [
      brazil,
      unitedStates,
      spain,
      mouse,
      particle,
    ] = await Future.wait([
      Utils.getAssetsBytes(AppAssets.svgs.brazil),
      Utils.getAssetsBytes(AppAssets.svgs.unitedStates),
      Utils.getAssetsBytes(AppAssets.svgs.spain),
      Utils.getAssetsBytes(AppAssets.svgs.mouse),
      Utils.getAssetsBytes(AppAssets.images.particle),
    ]);
    brazilSVG = brazil;
    unitedStatesSVG = unitedStates;
    spainSVG = spain;
    mouseSVG = mouse;
    particleIMG = particle;
  }

  late Uint8List brazilSVG;
  late Uint8List unitedStatesSVG;
  late Uint8List spainSVG;
  late Uint8List mouseSVG;
  late Uint8List particleIMG;
}
