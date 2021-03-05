import 'package:eye_test/screens/home_page/parent_page.dart';
import 'package:eye_test/screens/sign_pages/Sign_in.dart';
import 'package:eye_test/screens/splash/splash_screen.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ScreensController extends StatelessWidget {
  final BuildContext context;
  const ScreensController({Key key, this.context}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auths>(context);
    switch(user.status){
      case Status.Uninitialized:
        return CircularProgressIndicator();
      case Status.Unauthenticated:
        return SplashScreen();
      case Status.Authenticating:
        return Login(context: context);
      case Status.Authenticated:
        return ParentPage();
      default: return Login();
    }
  }
}