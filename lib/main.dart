
import 'package:easy_localization/easy_localization.dart';
import 'package:eye_test/config/routes.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/services/Geo_locator/geo_locator_service.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auths.initialize(),
        ),
      ],
      child: EasyLocalization(
        child:  MyApp(),
        path: 'resources/langs',
        saveLocale: true,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('tr', 'TR'),
          Locale('fr', 'FR')
        ],
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final geoService = GeoLocatorService();

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (context) => geoService.getInitialLocation(),
      child: MaterialApp(
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
        initialRoute: 'OpeningPage',
        //home: ScreensController(),
      ),
    );
  }
}
