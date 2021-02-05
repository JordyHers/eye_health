import 'package:eye_test/theme/light_color.dart';
import 'package:flutter/material.dart';

class FontSizes {
  static double scale = 1.2;
  static double get body => 14 * scale;
  static double get bodySm => 12 * scale;
  static double get title => 16 * scale;
  static double get titleSmall => 16 * scale;
  static double get titleM => 18 * scale;
  static double get sizeXXl => 28 * scale;
  static double get sizeXl => 17 * scale;
  static double get Large => 23 * scale;
}

class TextStyles {
  static TextStyle get title =>TextStyle(fontSize: FontSizes.title);
  static TextStyle get titleM =>TextStyle(fontSize: FontSizes.titleM);
  static TextStyle get titleNormal => title.copyWith(fontWeight: FontWeight.w500);
  static TextStyle get titleMedium => titleM.copyWith(fontWeight: FontWeight.w300);
  static TextStyle get h1Style => TextStyle(fontSize: FontSizes.sizeXXl, fontWeight: FontWeight.bold);
  static TextStyle get h2Style => TextStyle(fontSize: FontSizes.sizeXl, fontWeight: FontWeight.bold,color: Colors.black);
  static TextStyle get h3Large => TextStyle(fontSize: FontSizes.Large, fontWeight: FontWeight.bold,color: Colors.black);
  static TextStyle get headTitleColored=> TextStyle(fontSize: FontSizes.Large, fontWeight: FontWeight.bold,color: Colors.black);
  static TextStyle get body => TextStyle(fontSize: FontSizes.body, fontWeight: FontWeight.w300);
  static TextStyle get bodySm => body.copyWith(fontSize: FontSizes.bodySm);
}