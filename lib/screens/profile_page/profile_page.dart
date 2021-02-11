import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:eye_test/models/users.dart';
import 'package:eye_test/screens/profile_page/profile_page_listItems.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel _currentUser;
  String _imageUrl;
  String _name;
  String _email;
  File _imageFile;

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
    _name = _currentUser.name;
    _email = _currentUser.email;
    if (userProvider.languageisUpdated() != null) {
      print(' Profile Page : Reloaded ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.background,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBarButton(
                        icon: Icons.arrow_back,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                AvatarImage(),
                SizedBox(
                  height: 20,
                ),
                SocialIcons(),
                SizedBox(height: 20),
                Text(
                  _name ?? 'Kullanıcı',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  _email ?? '@myemail.com',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 15),
                Text(
                  'Mobil Uygulama Geliştirici ve Açık kaynak sağlayıcı.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                ProfileListItems(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  const AppBarButton({this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(shape: BoxShape.circle, color: LightColor.background, boxShadow: [
        BoxShadow(
          color: LightColor.black,
          offset: Offset(1, 1),
          blurRadius: 10,
        ),
        BoxShadow(
          color: LightColor.black,
          offset: Offset(-1, -1),
          blurRadius: 10,
        ),
      ]),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: LightColor.accentBlue,
      ),
    );
  }
}

class AvatarImage extends StatefulWidget {
  @override
  _AvatarImageState createState() => _AvatarImageState();
}

class _AvatarImageState extends State<AvatarImage> {
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
    return Container(
      width: 150,
      height: 150,
      padding: EdgeInsets.all(8),
      decoration: avatarDecoration,
      child: Container(
        decoration: avatarDecoration,
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: _imageUrl == null
                  ? AssetImage('assets/images/users.jpg')
                  : NetworkImage(
                      _imageUrl,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class SocialIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialIcon(
          color: Color(0xFF102397),
          iconData: facebook,
          onPressed: () {},
        ),
        SocialIcon(
          color: Color(0xFFff4f38),
          iconData: googlePlus,
          onPressed: () {},
        ),
        SocialIcon(
          color: Color(0xFF38A1F3),
          iconData: twitter,
          onPressed: () {},
        ),
        SocialIcon(
          color: Color(0xFF2867B2),
          iconData: linkedin,
          onPressed: () {},
        )
      ],
    );
  }
}

class SocialIcon extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final Function onPressed;

  SocialIcon({this.color, this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: RawMaterialButton(
          shape: CircleBorder(),
          onPressed: onPressed,
          child: Icon(iconData, color: Colors.white),
        ),
      ),
    );
  }
}

class ProfileListItems extends StatelessWidget {
  final Auths _auths = Auths.initialize();
  Status _status = Status.Uninitialized;
  Status get status => _status;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          ProfileListItem(
            icon: LineAwesomeIcons.user_shield,
            onPressed: () {},
            text: 'contact us'.tr().toString(),
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.history,
            onPressed: () {
              Navigator.pushNamed(context, '/profile_page_main');
            },
            text: 'update profile'.tr().toString(),
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.cog,
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            text: 'settings'.tr().toString(),
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.alternate_sign_out,
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      //this right here
                      child: Container(
                        height: 200,
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '       Are you sure ?'.tr().toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 280.0,
                                child: RaisedButton(
                                  onPressed: () async {
                                    await _auths.signOut().then((value) =>  Navigator.pushReplacementNamed(context, '/Sign_in'));
                                    
                                    _status = Status.Unauthenticated;
                                  },
                                  child: Text(
                                    'yes'.tr().toString(),
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                  color: LightColor.green,
                                ),
                              ),
                              SizedBox(
                                width: 280.0,
                                child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'no'.tr().toString(),
                                      style: TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                    color: LightColor.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            text: 'log out'.tr().toString(),
            hasNavigation: false,
          ),
        ],
      ),
    );
  }
}
