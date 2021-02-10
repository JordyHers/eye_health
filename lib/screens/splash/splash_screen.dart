import 'package:easy_localization/easy_localization.dart';
import 'package:eye_test/screens/splash/splash_content.dart';
import 'package:eye_test/size_config.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;

  List<Map<String, String>> splashData = [
    {
      "text": "Hello".tr(),
      "image": "assets/images/undraw_play_time_7k7b.svg"
    },
    {
      "text":
      "control the time your kids spend on screen",
      "image": "assets/images/Chat-rafiki.svg"
    },
    {
      "text": " because we care",
      "image": "assets/images/Devices-rafiki.svg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return SafeArea(

      child: SizedBox(

        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[


                    Spacer(flex: 3),
                    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: LightColor.accentBlue,
                      onPressed: (){
                      Navigator.pushReplacementNamed(context, '/Sign_in');
                      },
                      child: Text(
                        "Devam et",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          color: Colors.white,
                        ),
                      ),
                    ),Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                            (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? LightColor.purpleLight : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
