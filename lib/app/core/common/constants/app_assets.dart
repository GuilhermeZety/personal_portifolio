// ignore_for_file: unused_field

import 'package:flutter/foundation.dart';

class AppAssets {
  static AppImages images = AppImages();
  static final AppSvgs svgs = AppSvgs();
  static final AppGifs gifs = AppGifs();
}

class AppImages {
  static String get _path => !kDebugMode ? 'assets/images' : 'images';
  final String particle = '$_path/particle.png';
}

class AppSvgs {
  static String get _path => !kDebugMode ? 'assets/svgs' : 'svgs';
  final String brazil = '$_path/brazil.svg';
  final String spain = '$_path/spain.svg';
  final String unitedStates = '$_path/united-states.svg';
  final String mouse = '$_path/mouse.svg';
  final String pin = '$_path/pin.svg';
  final String discord = '$_path/discord.svg';
  final String github = '$_path/github.svg';
  final String linkedin = '$_path/linkedin.svg';
}

class AppGifs {
  static String get _path => !kDebugMode ? 'assets/gifs' : 'gifs';

  final String spinningCat = '$_path/spinning_cat.gif';
}
