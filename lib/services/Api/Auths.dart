import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:app_usage/app_usage.dart';
import 'package:eye_test/models/child_model.dart';
import 'package:eye_test/models/users.dart';

import 'package:eye_test/services/Api/users_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';



enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

abstract class BaseAuth {
  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String email, String password);

  Future<bool> sendEmailVerification();

  Future <bool> continueSignUp();

  Future<void> signOut();

  Future<void> resetPassword(String email);

  Future<bool> isEmailVerified();

  Future<void> reloadUserModel();
}

 class Auths with ChangeNotifier implements BaseAuth {

   final _firebaseAuth = FirebaseAuth.instance;
  List<AppUsageInfo> _infos = <AppUsageInfo> [];
  List<AppUsageInfo> get infos => _infos;

StreamController <User> _stream = StreamController();

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  //UnmodifiableListView <ChildModel> get child => UnmodifiableListView(_childModel);


  final FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  Status get status => _status;
  User get user => _firebaseAuth.currentUser;

  final UserServices _userServices = UserServices();

  UserModel get userModel => _userModel;
  UserModel get currentUser => _userModel;

  UserModel _userModel ;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  String _token;
  bool isLogged = false;

  Auths.initialize(): _auth = FirebaseAuth.instance{
    _auth.authStateChanges().listen(_onStateChanged);

  }



   set infos(List<AppUsageInfo> infos){
    _infos =infos;
    notifyListeners();
   }




  @override
  Future<bool> continueSignUp() async {
    _status = Status.Authenticating;
    notifyListeners();
    _userServices.createUser({
      'name': user.displayName,
      'email': user.email,
      'image': user.photoURL,
      'uid': user.uid,});

    print('continue From SignUp called  in Auths.dart file\n'
        '----------------------------------------------------');
    print(_userModel.toJson());
    return true;

  }

  @override
  Future<bool> signIn(String email, String password) async {
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }

  }

  @override
  Future<bool> signUp(String email, String password) async {
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  @override
  Future<void> reloadUserModel()async{
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

   Future<void> languageisUpdated()async{
     _userModel = await _userServices.getUserById(user.uid);
     notifyListeners();
   }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await _auth.signOut();
    await googleSignIn.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }


  void getUsageStats() async {
    try {
      var endDate = DateTime.now();
      var startDate = endDate.subtract(Duration(hours: 1));
      var infoList = await AppUsage.getAppUsage(startDate, endDate);
      _infos = infoList;
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  void VerifyInfoscurrentUser(){
    try {
      print('Verify user infos called \n'
          '-----------------------------------');
      print(currentUser.toJson());
    } on Exception catch (e) {
      print(' ---------------- COULD NT COMPLETE VERIFY USER INFOS');
    }

  }

  void setTokenAndAppList() async {
    try {
      await _firebaseMessaging.getToken().then((token) {
        _token = token;
        print('Device Token: $_token');
      });

      print('Auths.dart  ________________________');
      print(_userModel.appsUsageModel);
    }
    catch(e){
      print(e);
    }
  }

  @override
  // ignore: missing_return
  Future<bool> sendEmailVerification() async {
    var user = await  _auth.currentUser;
    try {
      await user.sendEmailVerification();
      return true;
    } catch (e) {
      
      print('Bir hata oldu');
      print(e.message);
    }
  }

  @override
  Future<bool> isEmailVerified() async {
    var user = await _auth.currentUser;
    return user.emailVerified;
  }

  @override
  Future<void> resetPassword(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }



  Future<void> _onStateChanged(User user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _userModel = await _userServices.getUserById(user.uid);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );
  }

}













// Future <FirebaseUser> signUpWithFacebook() async {
//   try{
//     _status = Status.Authenticating;
//     notifyListeners();
//     var facebookLogin = FacebookLogin();
//     var  result = await facebookLogin.logIn(['email']);
//     if (result.status == FacebookLoginStatus.loggedIn){
//       _status = Status.Authenticated;
//       notifyListeners();
//       final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken:result.accessToken.token);
//       final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
//       return user;
//     }
//   }catch(e){
//     print(e.message);
//   }
// }