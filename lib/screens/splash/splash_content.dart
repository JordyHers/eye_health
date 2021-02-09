import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:easy_localization/easy_localization.dart';

import '../../size_config.dart';



class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),

        Text(
          "parental control".tr(),
          style: TextStyle(
            fontSize: getProportionateScreenWidth(25),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          style: TextStyle(fontSize: 21,fontWeight: FontWeight.w100),
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        SvgPicture.asset(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
