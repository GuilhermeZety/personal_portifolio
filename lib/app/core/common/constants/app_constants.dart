class AppConstants {
  static String prismicUrl = 'https://zety-portifolio.cdn.prismic.io/api/v2';

  static String getFullPrismicUrl(String ref) => '$prismicUrl/documents/search?ref=$ref';
}
