// ignore_for_file: unused_field

import 'package:flutter/foundation.dart';

class AppAssets {
  static AppImages images = AppImages();
  static final AppSvgs svgs = AppSvgs();
  static final AppGifs gifs = AppGifs();
}

class AppImages {
  // static String get _path => !kDebugMode ? 'assets/images' : 'images';
}

class AppSvgs {
  static String get _path => !kDebugMode ? 'assets/svgs' : 'svgs';
  final String brazil = '$_path/brazil.svg';
  final String spain = '$_path/spain.svg';
  final String unitedStates = '$_path/united-states.svg';
  final String mouse = '$_path/mouse.svg';
}

class AppGifs {
  static String get _path => !kDebugMode ? 'assets/gifs' : 'gifs';

  final String spinningCat = '$_path/spinning_cat.gif';
}
