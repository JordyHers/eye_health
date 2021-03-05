import 'package:eye_test/components/focus_mode/focus_mode.dart';
import 'package:eye_test/config/screens_controller.dart';
import 'package:eye_test/config/splash_control.dart';
import 'package:eye_test/screens/home_page/parent_page.dart';
import 'package:eye_test/screens/home_page/child_home.dart';
import 'package:eye_test/screens/landing_page/landing_page.dart';
import 'package:eye_test/screens/register_kids/register_kids.dart';
import 'package:eye_test/screens/setting_page/change_language.dart';
import 'package:eye_test/screens/setting_page/profile_page.dart';
import 'package:eye_test/screens/setting_page/profile_page_main.dart';
import 'package:eye_test/screens/setting_page/update_profile_page.dart';
import 'package:eye_test/screens/sign_pages/Sign_in.dart';
import 'package:eye_test/screens/sign_pages/Signup_page.dart';
import 'package:eye_test/screens/splash/Splash_page.dart';
import 'package:eye_test/services/AlgoliaSearch/search_algolia.dart';
import 'package:flutter/material.dart';


class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => SplashPage(),
      '/parent_page': (_) => ParentPage(),
      '/Signup_page': (_) => SignUp(),
      '/Sign_in': (_) => Login(),
      '/register_kids':(_)=> RegisterChild(),
      '/child_home':(_)=> ChildHomePage(),
      '/screens_controller': (_) => ScreensController(),
      '/profile_page_main': (_) => ProfilePageBody(),
      '/profile_page': (_) => ProfilePage(),
      '/update_profile_page': (_) => UpdateProfilePage(),
      '/change_language': (_) => SettingsPage(),
      '/focus_mode': (_) => FocusMode(),
      '/search_algolia': (_) => SearchBar(),
      '/splash_control': (_) => SplashControl(),
      '/landing_page': (_) => LandingPage(),
    };
  }
}
