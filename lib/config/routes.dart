import 'package:eye_test/components/focus_mode/focus_mode.dart';
import 'package:eye_test/components/geo_locate/geo.dart';
import 'package:eye_test/components/installed_apps.dart';
import 'package:eye_test/config/screens_controller.dart';
import 'package:eye_test/config/splash_control.dart';
import 'package:eye_test/screens/home_page/Homepage.dart';
import 'package:eye_test/screens/home_page/child_home.dart';
import 'package:eye_test/screens/opening_page/opening_page.dart';
import 'package:eye_test/screens/profile_page/profile_page.dart';
import 'package:eye_test/screens/profile_page/profile_page_main.dart';
import 'package:eye_test/screens/profile_page/update_profile_page.dart';
import 'package:eye_test/screens/register_kids/register_kids.dart';
import 'package:eye_test/screens/settings/change_language.dart';
import 'package:eye_test/screens/signIn/Sign_in.dart';
import 'package:eye_test/screens/signup_page/Signup_page.dart';
import 'package:eye_test/screens/splash/Splash_page.dart';
import 'package:eye_test/services/AlgoliaSearch/search_algolia.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => SplashPage(),
      '/Homepage': (_) => HomePage(),
      '/Signup_page': (_) => SignUp(),
      '/Sign_in': (_) => Login(),
      '/register_kids':(_)=> RegisterChild(),
      '/child_home':(_)=> ChildHomePage(),
      '/screens_controller': (_) => ScreensController(),
      '/profile_page_main': (_) => ProfilePageBody(),
      '/profile_page': (_) => ProfilePage(),
      '/update_profile_page': (_) => UpdateProfilePage(),
      '/geo': (_) => Consumer<Position>(builder: (context, position, widget) {
            return (position != null)
                ? Geo(position)
                : Center(child: CircularProgressIndicator());
          }),
      '/installed_apps': (_) => InstalledApps(),
      '/change_language': (_) => SettingsPage(),
      '/focus_mode': (_) => FocusMode(),
      '/search_algolia': (_) => SearchBar(),
      '/splash_control': (_) => SplashControl(),
      '/opening_page': (_) => OpeningPage(),
    };
  }
}
