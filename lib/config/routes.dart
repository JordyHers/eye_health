import 'package:eye_test/components/focus_mode/focus_mode.dart';
import 'package:eye_test/components/screen_time/screen_time.dart';
import 'package:eye_test/config/screens_controller.dart';
import 'package:eye_test/config/splash_control.dart';
import 'package:eye_test/screens/home_page/Homepage.dart';
import 'package:eye_test/screens/opening_page/opening_page.dart';
import 'package:eye_test/screens/profile_page/hero_animation_profile_page.dart';
import 'package:eye_test/screens/profile_page/profile_page.dart';
import 'package:eye_test/screens/profile_page/profile_page_main.dart';
import 'package:eye_test/screens/profile_page/update_profile_page.dart';
import 'package:eye_test/screens/see_more_page/see_more_doctors.dart';
import 'package:eye_test/screens/see_more_page/see_more_page.dart';
import 'package:eye_test/screens/settings/settings.dart';
import 'package:eye_test/screens/signIn/Sign_in.dart';
import 'package:eye_test/screens/signup_page/Signup_page.dart';
import 'package:eye_test/screens/splash/Splash_page.dart';
import 'package:eye_test/screens/splash/splash_screen.dart';
import 'package:eye_test/services/AlgoliaSearch/search_bar_algolia.dart';
import 'package:flutter/material.dart';
import 'package:eye_test/widgets/custom_routes.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => SplashPage(),
      '/Homepage': (_) => HomePage(),
      '/Signup_page':(_)=> SignUp(),
      '/Sign_in':(_)=> Login(),
      '/screens_controller': (_) => ScreensController(),
      '/profile_page_main': (_) => ProfilePageBody(),
      '/profile_page': (_) => ProfilePage(),
      '/update_profile_page': (_) => UpdateProfilePage(),
      '/see_more_page': (_) => MorePage(),
      '/see_more_doctors': (_) => MoreDoctorsPage(),
      '/screen_time': (_) => ScreenTime(),
      '/hero_animation_profile_page': (_) =>HeroProfile(),
      '/search_bar_algolia':(_) => SearchBar(),
      '/settings':(_) => SettingsPage(),
      '/focus_mode':(_) => FocusMode(),
      '/search_bar_algolia':(_) => SearchBar(),
      '/splash_control':(_) => SplashControl(),
      '/opening_page':(_)=> OpeningPage(),

    };
  }

  static Route onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return null;
    }
    // switch (pathElements[1]) {
    //   case "DetailPage":
    //     return CustomRoute<bool>(
    //         builder: (BuildContext context) => DetailPage(model: settings.arguments,));
    //
    // }
  }
}