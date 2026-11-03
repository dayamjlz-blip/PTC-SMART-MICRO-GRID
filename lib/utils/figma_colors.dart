import 'package:flutter/material.dart';

class FigmaColors {
  FigmaColors._();

  // Palet biru (terang ke gelap)
  static const Color blueLightest = Color(0xFFD9E1F1);
  static const Color blueLight = Color(0xFF83B5E7);
  static const Color blueMedium = Color(0xFF4566AD);
  static const Color blueDark = Color(0xFF31487A);

  // Status
  static const Color green = Color(0xFF0FF140);
  static const Color orange = Color(0xFFE68907);
  static const Color red = Color(0xFFF7171E);

  // Netral
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF757575);

  // Gradasi latar belakang halaman
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [blueLightest, blueMedium],
  );
}