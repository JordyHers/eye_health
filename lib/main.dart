import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eye_test/config/screens_controller.dart';

import 'package:eye_test/provider/app_provider.dart';


import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eye_test/config/routes.dart';






void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => Auths.initialize(),
      ),
      ChangeNotifierProvider.value(value: AppProvider()),

    ],
    child: EasyLocalization(child: MyApp(),path: "resources/langs",saveLocale: true,supportedLocales: [
      Locale('en','US'),
      Locale('tr','TR'),
      Locale('fr','FR')
    ],),
  ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Time's Up",
      theme: AppTheme.lightTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: Routes.getRoute(),
      onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
      initialRoute: "OpeningPage",
       //home: ScreensController(),
    );
  }
}

