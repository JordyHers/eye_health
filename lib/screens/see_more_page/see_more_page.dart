import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Center(
          child: Text(
            ' See MORE PAGE ',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 23, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
