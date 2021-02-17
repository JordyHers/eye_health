import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_test/models/users.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:eye_test/size_config.dart';
import 'package:eye_test/theme/theme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';




class UpdateProfilePage extends StatefulWidget {


  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> with ChangeNotifier {
  UserModel _currentUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  final snackbar = SnackBar(content: Text('Guncelledi'),);
  final snackbar2 = SnackBar(content: Text('Bir hata oldu'),);

  String _imageUrl;
  File _imageFile;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<Auths>(context, listen: false);
    if (userProvider.currentUser != null) {
      _currentUser = userProvider.currentUser;
    } else {
      _currentUser = UserModel(_currentUser.name);
    }
    _imageUrl = _currentUser.image;

  }
  void removeError({String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }


  // ignore: missing_return
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
    final userProvider = Provider.of<Auths>(context);
    userProvider.reloadUserModel();

    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  child: _showImage(),
                ),
              ),
              _imageFile == null && _imageUrl == null
                  ? ButtonTheme(
                child: RaisedButton(
                  color: Colors.deepOrangeAccent[200],
                  onPressed: () => _getLocalImage(),
                  child: Text(
                    'Resim ekle',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ):SizedBox(height: 10,),

              //=================================  NAME FIELD ========================================

              _buildNameField(),
              _buildSurnameField(),
              _buildEmailField(),
              _builAddresField(),
              _buildPhoneField(),

              Container(
                margin: EdgeInsets.fromLTRB(8,8,8,8),
                height: getProportionateScreenHeight(63),
                width: getProportionateScreenWidth(150),
                decoration: BoxDecoration(
                    color: LightColor.lightblack,
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  //alignment: Alignment.center,
                  child: ListTile(
                      onTap: ()  {
                        print('CLICKED KAYDET');
                        Fluttertoast.showToast(msg: 'Bilgileriniz güncellendi',backgroundColor: Colors.lightGreen);
                        _saveImage();
                        userProvider.reloadUserModel();
                        notifyListeners();
                      },
                      trailing: Icon(Icons.save),
                      title: Center(
                        child: Text(
                          'Kaydet',
                          style: TextStyle(fontSize: 15,color: Colors.white),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  void _saveImage() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    var isUpdating = true;

    bool success = uploadUserImage(_currentUser, isUpdating, _imageFile);
    if (success){
      Scaffold.of(context).showSnackBar(snackbar);
      print('successful');

    }else{
      Scaffold.of(context).showSnackBar(snackbar2);
      print('unsuccessful');
    }
    print('name: ${_currentUser.name}');
    print('category: ${_currentUser.address}');
    print('experience: ${_currentUser.telephone.toString()}');
    print('_imageFile ${_imageFile.toString()}');
    print('_imageUrl $_imageUrl');
  }

  // ignore: always_declare_return_types
  uploadUserImage( UserModel user , bool isUpdating, File localFile) async {
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
  Widget _buildNameField() {
    return Container(
      margin: EdgeInsets.all(12),
      height: getProportionateScreenHeight(60),
      width: double.infinity,

      child: Container(
        child: TextFormField(
          decoration: InputDecoration(labelText: 'isim'),
          initialValue: _currentUser.name,
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: 15),
          validator: (String value) {
            if (value.isEmpty) {
              return 'İsim gerekli';
            }
            if (value.length < 3 || value.length > 20) {
              return "Ad, 3'ten fazla ve 20'den az harf içermelidir";
            }
            return null;
          },
          onSaved: (String value) {
            _currentUser.name = value  ;
          },

        ),
      ),
    );
  }
  Widget _buildSurnameField() {
    return Container(
      margin: EdgeInsets.all(12),
      height: getProportionateScreenHeight(60),
      width: double.infinity,
      child: Container(

        height: 100,
        width: 320,
        child: TextFormField(
          decoration: InputDecoration(labelText: 'soyisisim'),
          initialValue: _currentUser.surname,
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: 15),
          validator: (String value) {
            if (value.isEmpty) {
              return 'İsim gerekli';
            }

            // ignore: prefer_is_empty
            if (value.length < 0 || value.length > 15) {
              return "Soyad, 3'ten fazla ve 20'den az harf içermelidir";
            }
            return null;
          },
          onSaved: (String value) {

            _currentUser.surname= value;
          },

        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      margin: EdgeInsets.all(10),
      height: getProportionateScreenHeight(72),
      width: double.infinity,

      child: Container(

        width: 320,
        child: TextFormField(

          decoration: InputDecoration(labelText: 'E-mail'),
          initialValue: _currentUser.email,
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: 15),
          validator: (String value) {
            if (value.isEmpty) {
              return 'E posta gerekli';
            }
            if (value.isEmpty || value.length > 35) {
              return "Eposta, 20'den az karakter içermelidir";
            }
            return null;
          },
          onSaved: (String value) {
            _currentUser.email = value;
          },

        ),
      ),
    );
  }
  Widget _buildPhoneField() {
    return Container(
      margin: EdgeInsets.all(10),
      height: getProportionateScreenHeight(60),
      width: double.infinity,

      child: Container(
        height: 100,
        width: 320,
        child: TextFormField(
          decoration: InputDecoration(labelText: '5XXXXXXXXX'),
          initialValue: _currentUser.telephone,
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: 15),
          validator: (String value) {
            if (value.isEmpty) {
              return 'Hata oldu';
            }

            if (value.length < 10 || value.length > 10) {
              return 'Numara  ile başlamalıdır';
            }

            return null;
          },
          onSaved: (String value) {
            _currentUser.telephone = value;
          },

        ),
      ),
    );
  }
  Widget _builAddresField() {
    return Container(
      margin: EdgeInsets.all(10),
      height: getProportionateScreenHeight(60),
      width: double.infinity,

      child: Container(

        height: 70,
        width: 320,
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Açık adres'),
          initialValue: _currentUser.address,
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: 15),
          validator: (String value) {
            if (value.isEmpty) {
              return 'Adres gerekli';
            }

            if (value.length < 3 || value.length > 100) {
              return "Eposta, 20'den az karakter içermelidir";
            }
            return null;
          },
          onSaved: (String value) {
            _currentUser.address = value;
          },

        ),
      ),
    );
  }
}