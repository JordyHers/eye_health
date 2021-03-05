

import 'package:eye_test/config/screens_controller.dart';
import 'package:flutter/material.dart';

import 'size_config.dart';
class SplashControl extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScreensController(context: context),
    );
  }
}
