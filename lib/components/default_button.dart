import 'package:eye_test/theme/light_color.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(120),
      height: getProportionateScreenHeight(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: LightColor.purple,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(15),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
