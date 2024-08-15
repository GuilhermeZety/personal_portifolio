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
  static const String _path = 'assets/svgs';
}

class AppGifs {
  static const String _path = 'assets';

  final String spinningCat = '$_path/spinning_cat.gif';
}
