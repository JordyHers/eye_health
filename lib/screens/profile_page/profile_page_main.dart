import 'package:eye_test/screens/profile_page/update_profile_page.dart';
import 'package:flutter/material.dart';
class ProfilePageBody extends StatefulWidget {
  @override
  _ProfilePageBodyState createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: UpdateProfilePage()),
    );
  }
}
