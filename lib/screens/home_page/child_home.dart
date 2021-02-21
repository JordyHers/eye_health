import 'package:flutter/material.dart';

class ChildHomePage extends StatefulWidget {
  @override
  _ChildHomePageState createState() => _ChildHomePageState();
}

class _ChildHomePageState extends State<ChildHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('CHild Home')),
    );
  }
}
