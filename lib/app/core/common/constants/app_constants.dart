class AppConstants {
  static String prismicUrl = 'https://zety-portifolio.cdn.prismic.io/api/v2';
  static String prismicRef = 'ZvxMmhAAAB8AmOx7';

  static String get getFullPrismicUrl => '$prismicUrl/documents/search?ref=${AppConstants.prismicRef}';
}
