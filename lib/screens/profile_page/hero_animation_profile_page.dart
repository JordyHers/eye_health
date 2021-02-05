import 'package:eye_test/models/users.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeroProfile extends StatefulWidget {
  @override
  _HeroProfileState createState() => _HeroProfileState();
}

class _HeroProfileState extends State<HeroProfile> {
  String _imageUrl;
  UserModel _currentUser;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<Auths>(context, listen: false);
    if (userProvider.currentUser != null) {
      _currentUser = userProvider.currentUser;
    } else {
      _currentUser = UserModel();
    }
    _imageUrl = _currentUser.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(
            _imageUrl,
            height: 200,
            width: 180,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
