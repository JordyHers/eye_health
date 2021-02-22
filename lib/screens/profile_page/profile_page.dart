

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
  String _name;
  String _email;
 

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<Auths>(context, listen: false);

    if (userProvider.currentUser != null) {
      _currentUser = userProvider.currentUser;
    } else {
      _currentUser = UserModel();
    }
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
            padding: const EdgeInsets.only(top:18.0,left: 8,bottom: 8),
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
                SizedBox(height: 20,),
                Row(
                  children: [
                    SizedBox(width: 20,),
                    AvatarImage(),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(right:4.0),
                        child: Text(
                          _name ?? 'Kullanıcı',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _email ?? '@myemail.com',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],)

                  ],
                ),
                SizedBox(height: 25),
                ProfileListItems(),
                ListTile(leading: IconButton(icon: Icon(Icons.contact_support_sharp) ,
                  onPressed: (){

                },),
                title: Text('Developed by Jordy Hershel',style: TextStyle(color: Colors.deepOrange,fontSize: 15),),)
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
      height: 45,
      decoration: BoxDecoration(shape: BoxShape.circle, color: LightColor.accentBlue, boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(1, 1),
          blurRadius: 10,
        ),

      ]),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: Colors.white,
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
      width: 120,
      height: 100,
      padding: EdgeInsets.all(3),
      decoration: avatarDecoration,
      child: Container(
        decoration: avatarDecoration,
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.contain,
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


class ProfileListItems extends StatefulWidget {
  @override
  _ProfileListItemsState createState() => _ProfileListItemsState();
}

class _ProfileListItemsState extends State<ProfileListItems> {
  final Auths _auths = Auths.initialize();

  Status _status = Status.Uninitialized;

  Status get status => _status;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[

          ProfileListItem(
            icon: LineAwesomeIcons.history,
            onPressed: () {
              Navigator.pushNamed(context, '/profile_page_main');
            },
            text: 'update profile'.tr().toString(),
          ),

          ProfileListItem(
            icon: LineAwesomeIcons.language,
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            text: 'change language'.tr().toString(),
          ),

          ProfileListItem(
            icon: LineAwesomeIcons.moon,
            onPressed: () {

            },
            text: 'dark mode'.tr().toString(),
          ),

          ProfileListItem(
            icon: LineAwesomeIcons.mobile_phone,
            onPressed: () {
           Navigator.pushNamed(context, '/register_kids');
            }, text: "Add a Child's device".tr().toString(),
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
                                  color: LightColor.accentBlue,
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
          ProfileListItem(
            icon: LineAwesomeIcons.user_shield,
            onPressed: () {},
            text: 'contact us'.tr().toString(),
          ),
        ],
      ),
    );
  }
}
