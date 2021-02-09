import 'package:eye_test/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


class OpeningPage extends StatefulWidget {

  @override
  _OpeningPageState createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {

  Widget _parentsCard(String title, String subtitle,
      {Color color, Color lightColor}) {
    TextStyle titleStyle = TextStyles.title.bold.black;
    TextStyle subtitleStyle = TextStyles.title.bold.black;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.title.bold.black;
      subtitleStyle = TextStyles.title.bold.black;
    }
    return AspectRatio(
      aspectRatio: 12 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Parents-rafiki.png'),
            fit: BoxFit.cover,
          ),
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                // Positioned(
                //   top: -20,
                //   left: -20,
                //   child: CircleAvatar(
                //     backgroundColor: lightColor,
                //     radius: 60,
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Text(title, style: titleStyle).hP8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: subtitleStyle,
                      ).hP8,
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ).ripple(() {
           Navigator.pushReplacementNamed(context, '/Homepage');
        }, borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  Widget _childrenCard(String title, String subtitle,
      {Color color, Color lightColor}) {
    TextStyle titleStyle = TextStyles.title.bold.black;
    TextStyle subtitleStyle = TextStyles.body.bold.black;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.title.bold.black;
      subtitleStyle = TextStyles.title.bold.black;
    }
    return AspectRatio(
      aspectRatio: 12 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/play-time-screen-time-media-time.jpg'),
            fit: BoxFit.cover,
          ),
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                // Positioned(
                //   top: -20,
                //   left: -20,
                //   child: CircleAvatar(
                //     backgroundColor: lightColor,
                //     radius: 60,
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Text(title, style: titleStyle).hP8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: subtitleStyle,
                      ).hP8,
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ).ripple(() {
          // Navigator.pushNamed(context, '/focus_mode');
        }, borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 70,),
                _parentsCard("parent".tr().toString(), "control".tr().toString(),
                    color: LightColor.purple, lightColor: LightColor.purpleLight),
                SizedBox(height: 35,),
                _childrenCard("child".tr().toString(), "time".tr().toString(),
                    color: LightColor.purple, lightColor: LightColor.purpleLight)
              ],
            ),
          )
          
      ),
      
    );
  }
}