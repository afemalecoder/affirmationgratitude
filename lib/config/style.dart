import 'package:flutter/material.dart';

// colours
const Color kcGreyColour = Color(0xff868686);

//palette/shades of the primary colour
class Palette {
  static const MaterialColor kcToLight = MaterialColor(0xff464bbd, <int, Color>{
    50: Color(0xff595dc4),
    100: Color(0xff6b6fca),
    200: Color(0xff7e81d1),
    300: Color(0xff9093d7),
    400: Color(0xffa3a5de),
    500: Color(0xffb5b7e5),
    600: Color(0xffc8c9eb),
    700: Color(0xffdadbf2),
    800: Color(0xffededf8),
    900: Color(0xff000000),
  });
}

// font sizing
const double kBodyTextSize = 17;
// body text style
const TextStyle ktsGreyBodyText = TextStyle(
  color: kcGreyColour,
  fontSize: kBodyTextSize,
);
