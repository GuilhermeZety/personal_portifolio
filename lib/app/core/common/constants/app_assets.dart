// ignore_for_file: unused_field

class AppAssets {
  static AppImages images = AppImages();
  static final AppSvgs svgs = AppSvgs();
  static final AppGifs gifs = AppGifs();
}

class AppImages {
  static const String _path = 'assets/images';
}

class AppSvgs {
  static const String _path = 'svgs/';
  final String brazil = '${_path}brazil.svg';
  final String spain = '${_path}spain.svg';
  final String unitedStates = '${_path}united-states.svg';
  final String mouse = '${_path}mouse.svg';
}

class AppGifs {
  static const String _path = 'assets';

  final String spinningCat = '$_path/spinning_cat.gif';
}
