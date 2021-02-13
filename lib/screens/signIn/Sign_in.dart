import 'dart:ui';

import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/services/Google_Service/google_signin.dart';
import 'package:eye_test/services/Internet_Connection/network_bloc.dart';
import 'package:eye_test/services/Internet_Connection/network_event.dart';
import 'package:eye_test/services/Internet_Connection/network_state.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_svg/svg.dart';

// import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auths>(context);
    return Scaffold(
      key: _key,
      body: BlocProvider(
          create: (context) => NetworkBloc()..add(ListenConnection()),
          child: BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, state) {
              if (state is ConnectionFailure) {
                return Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 200, 8.0, 8.0),
                      child: Column(
                        children: [
                          Center(child: Image.asset('assets/png/no-disconnect.png')),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'İnternet bağlantısı yok',
                            style: TextStyle(fontSize: 23),
                          )
                        ],
                      ),
                    )));
              }
              if (state is ConnectionSuccess) {
                return Stack(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[350],
                                blurRadius: 20.0, // has the effect of softening the shadow
                              )
                            ],
                          ),
                          child: Form(
                              key: _formKey,
                              child: ListView(
                                children: <Widget>[
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                        alignment: Alignment.topCenter,
                                        child: SvgPicture.asset(
                                          'assets/images/Login.svg',
                                          width: 260.0,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey.withOpacity(0.2),
                                      elevation: 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: TextFormField(
                                          controller: _email,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'E-posta',
                                            icon: Icon(Icons.alternate_email),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              Pattern pattern =
                                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                              var regex = RegExp(pattern);
                                              if (!regex.hasMatch(value)) {
                                                return 'Please make sure your email address is valid';
                                              } else {
                                                return null;
                                              }
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey.withOpacity(0.2),
                                      elevation: 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: TextFormField(
                                          controller: _password,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'password',
                                            icon: Icon(Icons.lock_outline),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'The password field cannot be empty';
                                            } else if (value.length < 6) {
                                              return 'the password has to be at least 6 characters long';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(74.0, 8.0, 74.0, 8.0),
                                    child: Material(
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: LightColor.purple,
                                        elevation: 0.0,
                                        child: MaterialButton(
                                          onPressed: () async {
                                            if (_formKey.currentState.validate()) {
                                              await user
                                                  .signIn(_email.text, _password.text)
                                                  .then((value) => Navigator.pushReplacementNamed(context, '/Homepage'));

                                              if (!await user.signIn(_email.text, _password.text)) {
                                                _key.currentState.showSnackBar(SnackBar(content: Text('A mistake occured')));
                                              }
                                            }
                                          },
                                          minWidth: MediaQuery.of(context).size.width,
                                          child: Text(
                                            'Sign in',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                                          ),
                                        )),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                    
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context, '/Signup_page');
                                              },
                                              child: Text(
                                                'Log with new account ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(color: Colors.black),
                                              ))),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'other'.tr(),
                                            style: TextStyle(fontSize: 18, color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: MaterialButton(
                                              onPressed: ()  async{
                                              await   signInWithGoogle().then((result)  async {
                                                   // ignore: unawaited_futures
                                                  await  user.continueSignUp();
                                                 Navigator.pushReplacementNamed(context, '/Homepage');
                                                });
                                              },
                                              child: Image.asset(
                                                'assets/png/google_search.png',
                                                width: 30,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Text('');
              }
            },
          )),
    );
  }

  // Future<void> _handlePermissions() async {
  //   var statuses = await [
  //     Permission.notification,
  //     Permission.location,
  //     Permission.storage,
  //   ].request();
  //   print(statuses[Permission.location]);
  // }
}
