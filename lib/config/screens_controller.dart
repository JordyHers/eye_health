import 'file:///C:/Users/jordy/AndroidStudioProjects/Eye_Test/eye_test/lib/screens/splash/Splash_page.dart';
import 'package:flutter/material.dart';
import 'package:eye_test/provider/app_provider.dart';
import 'package:eye_test/screens/home_page/Homepage.dart';
import 'package:eye_test/screens/opening_page/opening_page.dart';
import 'package:eye_test/screens/signIn/Sign_in.dart';
import 'package:eye_test/screens/signup_page/Signup_page.dart';
import 'package:eye_test/screens/splash/splash_screen.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:eye_test/config/routes.dart';





class ScreensController extends StatefulWidget {
  //static String routeName = "/";

  @override
  _ScreensControllerState createState() => _ScreensControllerState();
}

class _ScreensControllerState extends State<ScreensController> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auths>(context);
    switch(user.status){
      case Status.Uninitialized:
        return CircularProgressIndicator();
      case Status.Unauthenticated:
        return SplashScreen();
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomePage();
      default: return Login();
    }
  }
}