import 'package:flutter/material.dart';
import 'package:eye_test/screens/splash/components/body.dart';
import 'package:eye_test/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}
