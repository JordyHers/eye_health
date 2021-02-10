import 'dart:ui';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:coin_accessoires/widgets/style.dart';
// import '../pages/signup.dart';
import 'package:eye_test/screens/home_page/Homepage.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/services/Google_Service/google_signin.dart';
import 'package:eye_test/services/Internet_Connection/network_bloc.dart';
import 'package:eye_test/services/Internet_Connection/network_event.dart';
import 'package:eye_test/services/Internet_Connection/network_state.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../widgets/loading.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import '../provider/user_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

// import 'home.dart';

const color = const Color(0xffF7EBE6);
const secColor = const Color(0xff565455);

class Login extends StatefulWidget {
  static String routeName = "/Sign_in";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auths>(context);
    return Scaffold(
      key: _key,
      body: BlocProvider(
              create: (context) => NetworkBloc()..add(ListenConnection()),
              child: BlocBuilder<NetworkBloc, NetworkState>(
                builder: (context, state) {
                  if (state is ConnectionFailure)
                    return Scaffold(
                        backgroundColor: Colors.white,
                        body: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,200,8.0,8.0),
                              child: Column(
                                children: [

                                  Center(child: Image.asset("assets/png/no-disconnect.png")),
                                  SizedBox(height: 10,),
                                  Text('İnternet bağlantısı yok',style: TextStyle(fontSize: 23),)
                                ],
                              ),
                            )));
                  if (state is ConnectionSuccess)
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
                                    blurRadius:
                                        20.0, // has the effect of softening the shadow
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
                                              'assets/images/optometrist.svg',
                                              width: 260.0,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            14.0, 8.0, 14.0, 8.0),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.grey.withOpacity(0.2),
                                          elevation: 0.0,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: TextFormField(
                                              controller: _email,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "E-posta",
                                                icon:
                                                    Icon(Icons.alternate_email),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  Pattern pattern =
                                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                                  RegExp regex =
                                                      new RegExp(pattern);
                                                  if (!regex.hasMatch(value))
                                                    return 'Please make sure your email address is valid';
                                                  else
                                                    return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            14.0, 8.0, 14.0, 8.0),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.grey.withOpacity(0.2),
                                          elevation: 0.0,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: TextFormField(
                                              controller: _password,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "parola",
                                                icon: Icon(Icons.lock_outline),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "The password field cannot be empty";
                                                } else if (value.length < 6) {
                                                  return "the password has to be at least 6 characters long";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            74.0, 8.0, 74.0, 8.0),
                                        child: Material(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: LightColor.purple,
                                            elevation: 0.0,
                                            child: MaterialButton(
                                              onPressed: () async {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  if(await user.signIn(_email.text, _password.text)){
                                                    Navigator.pushReplacementNamed(
                                                        context, "/Homepage");
                                                  }
                                                  if (!await user.signIn(
                                                      _email.text,
                                                      _password.text))
                                                    _key.currentState
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "Giriş sırasında hata oldu")));
                                                }

                                              },

                                              minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Text(
                                                "Oturum aç",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                            )),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
// Navigator.push(
//     context,
//     MaterialPageRoute(
//         builder: (context) => SmsPage()));
                                              },
                                              child: Text(
                                                "Sms Verification ",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                  onTap: () {
// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => SignUp()),
// );

                                                    Navigator.pushNamed(context,
                                                        "/Signup_page");
                                                  },
                                                  child: Text(
                                                    "Yeni bir hesap oluştur",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ))),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "diğer ",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: MaterialButton(
                                                  onPressed: () async {
                                                    await signInWithGoogle()
                                                        .then((result) async {
                                                      await user
                                                          .continueSignUp();
                                                      if (result != null) {
                                                        Navigator.pushNamed(
                                                            context,
                                                            HomePage.routeName);
                                                      }
                                                    });
                                                  },
                                                  child: Image.asset(
                                                    "assets/png/google_search.png",
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
                  else
                    return Text("");
                },
              )),
    );
  }

  Future<void> _handlePermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.notification,
      Permission.location,
      Permission.storage,
    ].request();
    print(statuses[Permission.location]);
  }
}
