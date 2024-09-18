import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = purple_600;
  static const Color secondary = pink_500;
  static const Color tertiary = yellow_500;

  static const Color white = Color(0xFFFFFFFF);
  static const Color grey_50 = Color(0xFFF7F7F8);
  static const Color grey_100 = Color(0xFFEEEEF0);
  static const Color grey_200 = Color(0xFFDADADD);
  static const Color grey_300 = Color(0xFFBABBBF);
  static const Color grey_400 = Color(0xFF94959C);
  static const Color grey_500 = Color(0xFF767681);
  static const Color grey_600 = Color(0xFF606169);
  static const Color grey_700 = Color(0xFF4E4E56);
  static const Color grey_800 = Color(0xFF29292E);
  static const Color grey_850 = Color(0xFF272727);
  static const Color grey_900 = Color(0xFF161818);
  static const Color grey_950 = Color(0xFF121414);

  static const Color black = Color(0xFF101010);

  //
  static const Color blue_600 = Color(0xFF313B4D);
  static const Color blue_700 = Color(0xFF21242E);
  static const Color blue_800 = Color(0xFF181C24);

  //
  static const Color purple_600 = Color(0xFF7D45F5);
  static const Color purple_800 = Color(0xFF521BBC);
  static const Color pink_500 = Color(0xFFEA335F);
  static const Color yellow_500 = Color(0xFFE3A049);

  static const LinearGradient gradient = LinearGradient(
    colors: [
      Color(0xFF6D45F5),
      Color(0xFFE76875),
      Color(0xFFC3802A),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  //
  static const Color info = Color(0xFF0079BC);
  static const Color success = Color(0xFF34E46F);
  static const Color warning = Color(0xFFF0B200);
  static const Color error = Color(0xFFD34A4A);

  static Color getRandomColor() {
    // Define a lista com as cores em formato hexadecimal
    List<Color> colors = [
      const Color(0xFF521BBC), // Cor #521BBC
      const Color(0xFF7D45F5), // Cor #7D45F5
      const Color(0xFFEA335F), // Cor #EA335F
      const Color(0xFFE3A049), // Cor #E3A049
    ];

    // Retorna uma cor aleatória da lista
    Random random = Random();
    return colors[random.nextInt(colors.length)].withOpacity(0.6);
  }
}
