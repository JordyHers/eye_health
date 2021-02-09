import 'package:flutter/material.dart';


class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
      backgroundColor: LightColor.background,
      primaryColor: LightColor.purple,
      cardTheme: CardTheme(color: LightColor.background),
      textTheme: TextTheme(display1: TextStyle(color: LightColor.black)),
      iconTheme: IconThemeData(color: LightColor.iconColor),
      bottomAppBarColor: LightColor.background,
      dividerColor: LightColor.grey,
      primaryTextTheme: TextTheme(
          body1: TextStyle(color:LightColor.titleTextColor)
      )
  );

  static TextStyle titleStyle = const TextStyle(color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle = const TextStyle(color: LightColor.subTitleTextColor, fontSize: 12);

  static TextStyle h1Style = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);

  static List<BoxShadow> shadow =  <BoxShadow>[
    BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];


  static EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(horizontal: 10,);

  static double fullWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  static double fullHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
}


extension TextStyleHelpers on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get white => copyWith(color: Colors.white);
  TextStyle get black => copyWith(color: Colors.black);
  TextStyle get grey => copyWith(color: Colors.grey);
  TextStyle get subTitleColor => copyWith(color: LightColor.subTitleTextColor);
}

extension PaddingHelper on Widget {
  Padding get p16 => Padding(padding: EdgeInsets.all(16), child: this);

  /// Set padding according to `value`
  Padding p(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Horizontal Padding 16
  Padding get hP4 => Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: this);
  Padding get hP8 => Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: this);
  Padding get hP16 => Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: this);

  /// Vertical Padding 16
  Padding get vP16 =>
      Padding(padding: EdgeInsets.symmetric(vertical: 16), child: this);
  Padding get vP8 =>
      Padding(padding: EdgeInsets.symmetric(vertical: 8), child: this);
  Padding get vP4 =>
      Padding(padding: EdgeInsets.symmetric(vertical: 8), child: this);
}

extension Extented on Widget {
  Expanded get extended => Expanded(
    child: this,
  );
}
extension CornerRadius on Widget {
  ClipRRect get circular=> ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(1000)),
    child: this,
  );
}
extension OnPressed on Widget {
  Widget  ripple(Function onPressed, {BorderRadiusGeometry borderRadius =const BorderRadius.all(Radius.circular(5))}) => Stack(
    children: <Widget>[
      this,
      Positioned(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius
            ),
            onPressed: () {
              if (onPressed != null) {
                onPressed();
              }
            },
            child: Container()),
      )
    ],
  );
}

/// Other values
/// --------------------------------------------------------------------
Duration kAnimationDuration = Duration(seconds: 2);

extension ExAlignment on Widget{
  Widget get alignTopCenter => Align(child: this,alignment: Alignment.topCenter,);
  Widget get alignCenter => Align(child: this,alignment: Alignment.center,);
  Widget get alignBottomCenter => Align(child: this,alignment: Alignment.bottomCenter,);
  Widget get alignBottomLeft => Align(child: this,alignment: Alignment.bottomLeft,);
}

class LightColor {
  static const Color background = Color(0XFFfefefe);

  static const Color titleTextColor = const Color(0xff1b1718);
  static const Color subTitleTextColor = const Color(0xffb9bfcd);

  static const Color skyBlue = Color(0xff71b4fb);
  static const Color lightBlue = Color(0xff7fbcfb);
  static const Color extraLightBlue = Color(0xffd9eeff);

  static const Color orange = Color(0xfffa8c73);
  static const Color lightOrange = Color(0xfffa9881);

  static const Color purple = Color(0xff8873f4);
  static const Color purpleLight = Color(0xff9489f4);
  static const Color purpleExtraLight = Color(0xffb1a5f6);

  static const Color grey = Color(0xffb8bfce);

  static const Color iconColor = Color(0xff000000);
  static const Color green = Color(0xff4cd1bc);
  static const Color lightGreen = Color(0xff5ed6c3);

  static const Color black = Color(0xff20262C);
  static const Color lightblack = Color(0xff5F5F60);
}

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