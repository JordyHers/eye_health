
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import  'package:easy_localization/easy_localization.dart';
import 'package:eye_test/models/child_model.dart';
import 'package:eye_test/models/users.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/services/Google_Service/google_signin.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';


class RegisterChild extends StatefulWidget {


  @override
  _RegisterChildState createState() => _RegisterChildState();
}

class _RegisterChildState extends State<RegisterChild> {
  UserModel _currentUser;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  String _imageUrl;
  File _imageFile;


  final TextEditingController _name = TextEditingController();
  final TextEditingController _surname = TextEditingController();




  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<Auths>(context, listen: false);
    if (userProvider.currentUser != null) {
      _currentUser = userProvider.currentUser;
    }

  }
  StatelessWidget _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Icon(Icons.person,size: 90,color: Colors.grey[500],);
    } else if (_imageFile != null) {
      print('showing image from local file');
      return
        InkWell(
          onTap: _getLocalImage,
          child: ClipOval(
            child: CircleAvatar(
              radius: 60,
              child: Image.file(
                _imageFile,
                fit: BoxFit.cover,
                width: 120,
              ),
            ),
          ),
        );
    } else if (_imageUrl != null) {
      print('showing image from url');

      return InkWell(
        onTap: _getLocalImage,
        child: ClipOval(
          child: CircleAvatar(
            radius: 60,
            child: Image.network(
              _imageUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              height: 250,
            ),
          ),
        ),
      );

    }
  }

  // ignore: always_declare_return_types
  _getLocalImage() async {
    // ignore: deprecated_member_use
    var imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 200);
    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: _key,
      body: Stack(
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
                        child: Column(
                          children: [
                          CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80,
                          child: _showImage(),
                        ),
                            ButtonTheme(
                              child: RaisedButton(
                                shape:
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                color: Colors.deepOrangeAccent,
                                onPressed: () => _getLocalImage(),
                                child: Text(
                                  'add picture'.tr(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
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
                            child: ListTile(
                              title: TextFormField(
                                controller: _name,
                                decoration: InputDecoration(hintText: 'Name', icon: Icon(Icons.person_outline), border: InputBorder.none),
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
                        padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _surname,
                                decoration: InputDecoration(hintText: 'Surname', icon: Icon(Icons.alternate_email), border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please make sure your email address is valid';
                                  }
                                  return ' Successful';
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(120.0, 108.0, 120.0, 8.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.blueAccent,
                            elevation: 0.0,
                            child: MaterialButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  // if (!await user.signUp(_email.text, _password.text)) {
                                  //   _key.currentState.showSnackBar(SnackBar(content: Text('Bir hata oldu')));
                                  //   return;
                                  // }
                                  // await user.continueSignUp();
                                  // await Navigator.pushNamed(context, '/Homepage');
                                }
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: Text(
                                'Register Kid',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0),
                              ),
                            )),
                      ),


                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  void _registerKid() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    var isUpdating = true;
    bool success = uploadUserChild(_currentUser, isUpdating, _imageFile);

  }

  // ignore: always_declare_return_types
  uploadUserChild( UserModel user , bool isUpdating, File localFile) async {
    //var reference = FirebaseFirestore.instance.collection('Users');

    if (localFile != null) {
      print('uploading image');
      var fileExtension = path.extension(localFile.path);
      print(fileExtension);
      var uuid = Uuid().v4();
      final firebaseStorageRef =
      FirebaseStorage.instance.ref().child('Users/ProfilePictures/$uuid$fileExtension');

      await firebaseStorageRef.putFile(localFile).onComplete.catchError((onError) {
        print(onError);
        return false;
      });

      String url = await firebaseStorageRef.getDownloadURL();
      print('download url: $url');
      uploadUser(user, isUpdating, imageUrl: url);
    } else {
      print('...skipping image upload');
      uploadUser(user, isUpdating);
    }
  }

  // ignore: always_declare_return_types
  uploadUser(UserModel user, bool isUpdating, {String imageUrl}) async {
    var userRef = FirebaseFirestore.instance.collection('Users');


    if (imageUrl != null) {
      user.image = imageUrl;
    }

    if (isUpdating) {
      await userRef.doc(user.id).update(user.toMap());
      print('updated user with id: ${user.id}');
    } else {

      var documentRef = await userRef.add(user.toMap());

      //_userModel.id = documentRef.documentID;
      print('uploaded doctor successfully: ${user.toString()}');
      await documentRef.set(user.toMap());

    }
  }
}
