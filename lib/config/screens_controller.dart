import 'package:eye_test/screens/home_page/Homepage.dart';
import 'package:eye_test/screens/signIn/Sign_in.dart';
import 'package:eye_test/screens/splash/splash_screen.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ScreensController extends StatefulWidget {


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