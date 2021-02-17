import 'package:easy_localization/easy_localization.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OpeningPage extends StatefulWidget {

  @override
  _OpeningPageState createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:Positioned(
            top: 20,
            child: Column(
              children: <Widget>[
                SizedBox(height: 7,),
                Text('Are you Parent or a Child'),


              ],
            ),
          )
          
      ),
      
    );
  }
}