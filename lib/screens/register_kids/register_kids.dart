
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import  'package:easy_localization/easy_localization.dart';
import 'package:eye_test/models/apps_model.dart';
import 'package:eye_test/models/child_model.dart';
import 'package:eye_test/models/users.dart';
import 'package:eye_test/repository/data_repository.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/services/Google_Service/google_signin.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:geolocator/geolocator.dart';
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
  ChildModel _childModel = ChildModel();

  DataRepository _rep = DataRepository();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _surname = TextEditingController();




  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<Auths>(context, listen: false);
    if (userProvider.currentUser != null) {
      _currentUser = userProvider.currentUser;
    }else {
      _currentUser = UserModel();
    }
     print (_currentUser.reference.id);
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
                                  return null;
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
                            child: RaisedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                   _formKey.currentState.save();
                                  _childModel.name =_name.text;
                                  _childModel.surname =_surname.text;
                                  var isUpdating = false;
                                  uploadUserChild(_childModel, isUpdating, _imageFile);
                                  print('register_kids.dart / Register kids------------');
                                  print(_childModel);


                                }
                              },

                              child: Text(
                                'Register Kid',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
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



  // ignore: always_declare_return_types
  uploadUserChild( ChildModel child , bool isUpdating, File localFile) async {
    //var reference = FirebaseFirestore.instance.collection('Users');

    if (localFile != null) {
      print('uploading image');
      var fileExtension = path.extension(localFile.path);
      print(fileExtension);
      var uuid = Uuid().v4();
      final firebaseStorageRef =
      FirebaseStorage.instance.ref().child('Child/"${_currentUser.reference.id}"/$uuid$fileExtension');

      await firebaseStorageRef.putFile(localFile).onComplete.catchError((onError) {
        print(onError);
        return false;
      });

      String url = await firebaseStorageRef.getDownloadURL();
      print('download url: $url');
      uploadChild(child, isUpdating, imageUrl: url);
    } else {
      print('...skipping image upload');
      uploadChild(child, isUpdating);
    }
  }

  // ignore: always_declare_return_types
  uploadChild(ChildModel child, bool isUpdating, {String imageUrl}) async {
    var collection = FirebaseFirestore.instance.collection('Data');
    // var uid = Uuid().v4();

    if (imageUrl != null) {
      child.image = imageUrl;

    }
    child.token = 'This is just an example';
    child.position = null;
    child.appsUsageModel =null;

    if (isUpdating) {
      await collection.doc(_currentUser.reference.id).update(child.toJson());
      print('updated User child with id: ${child.reference.id}');
    } else {
      await collection.doc(_currentUser.reference.id).update({'childModel':FieldValue.arrayUnion([child.toJson()])});
      // var documentRef = await collection.add(child.toJson());
      // //_userModel.id = documentRef.documentID;
      print('uploaded child successfully: ${child.toJson()}');
      // await documentRef.set(child.toJson());

    }
  }
}
