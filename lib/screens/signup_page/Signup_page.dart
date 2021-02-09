import 'package:eye_test/theme/theme.dart';
import 'dart:async';

import 'package:eye_test/screens/home_page/Homepage.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/services/Google_Service/google_signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../db/users.dart';
// import 'home.dart';

class SignUp extends StatefulWidget {
  static String routeName ='/signup_page';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  bool hidePass = true;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auths>(context);

    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating ? CircularProgressIndicator() : Stack(
        children: <Widget>[
          Padding(
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
                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              'assets/png/clip-sign-up.png',
                              width: 300.0,
                            )),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _name,
                                decoration: InputDecoration(
                                    hintText: "Isim",
                                    icon: Icon(Icons.person_outline),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Can't be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _email,
                                decoration: InputDecoration(
                                    hintText: "E posta",
                                    icon: Icon(Icons.alternate_email),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
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
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _password,
                                obscureText: hidePass,
                                decoration: InputDecoration(
                                    hintText: "parola",
                                    icon: Icon(Icons.lock_outline),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Ce champ ne peut etre vide";
                                  } else if (value.length < 6) {
                                    return "Le mot de passe doit avoir au moins 6 composants";
                                  }
                                  return null;
                                },
                              ),
                              trailing: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    setState(() {
                                      hidePass = false;
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(74.0, 8.0, 74.0, 8.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: LightColor.purple,
                            elevation: 0.0,
                            child: MaterialButton(
                              onPressed: () async{
                                if(_formKey.currentState.validate()){
                                  if(!await user.signUp( _email.text, _password.text)){
                                    _key.currentState.showSnackBar(SnackBar(content: Text("Erreur lors de l'enregistrement")));
                                    return;
                                  }
                                  user.continueSignUp();

                                  Navigator.pushNamed(context, "/Homepage");

                                }
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: Text(
                                "Kaydol",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Zaten hesabınız var mı",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                              ))),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Oturum aç", style: TextStyle(fontSize: 18,color: Colors.grey),),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                  child: MaterialButton(
                                      onPressed: () async{
                                        await  signInWithGoogle().then((result) async {
                                          await user.continueSignUp();
                                          if (result != null) {
                                            Navigator.pushNamed(context, HomePage.routeName);
                                          }
                                        });
                                      },
                                      child: Image.asset("assets/png/google_search.png", width: 30,)
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

}