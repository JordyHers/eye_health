import 'package:eye_test/theme/light_color.dart';
import 'package:flutter/material.dart';

class MoreDoctorsPage extends StatefulWidget {
  @override
  _MoreDoctorsPageState createState() => _MoreDoctorsPageState();
}

class _MoreDoctorsPageState extends State<MoreDoctorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.purpleLight,
        body: Center(
          child: Text(
            ' See more doctors ',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 23, color: Colors.black),
          ),
        ),
      );
  }
}
