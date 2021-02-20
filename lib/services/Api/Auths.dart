import 'dart:async';
import 'dart:io';

import 'package:eye_test/models/users.dart';
import 'package:eye_test/services/Api/users_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:uuid/uuid.dart';


enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

abstract class BaseAuth {
  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String email, String password);


  Future<bool> sendEmailVerification();

  Future <bool> continueSignUp();

  //Future <FirebaseUser>signUpWithFacebook();

  Future<void> signOut();

  Future<void> resetPassword(String email);

  Future<bool> isEmailVerified();

  Future<void> reloadUserModel();
}

 class Auths with ChangeNotifier implements BaseAuth {


  List<UserModel> _userList = [];
  String order;

  final FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  Status get status => _status;
  User get user => _user;
  final UserServices _userServices = UserServices();

  // OrderServices _orderServices = OrderServices();
  // List<OrderModel> _orders = [];
  //UnmodifiableListView <OrderModel> get orders => UnmodifiableListView(_orders);

  UserModel get currentUser => _userModel;
  //OrderModel get currentOrder => _orderModel;

  //OrderModel _orderModel;
  UserModel _userModel;


  //FacebookLogin facebookLogin = FacebookLogin();
  UserModel get userModel => _userModel;
  //OrderModel get orderModel => _orderModel;
  bool isLogged = false;

  Auths.initialize(): _auth = FirebaseAuth.instance{
    _auth.authStateChanges().listen(_onStateChanged);

  }



  set userList(List<UserModel> userList) {
    _userList = userList;
    notifyListeners();
  }

  set currentUser(UserModel userModel) {
    _userModel= userModel;
    notifyListeners();
  }

  // set currentOrder(OrderModel orderModel) {
  //   _orderModel= orderModel;
  //   notifyListeners();
  // }

  // ignore: always_declare_return_types
  addUser(UserModel model) async {
    _userList.insert(0, model);
    notifyListeners();
  }

  // ignore: always_declare_return_types
  deleteUser(UserModel model) async {
    _userList.removeWhere((_user) => _user.id == user.uid);
    notifyListeners();
  }

  @override
  Future<bool> continueSignUp() async {
    _status = Status.Authenticating;
    notifyListeners();
    _userServices.createUser({
      'name': user.displayName,
      'email': user.email,
      'address': 'adres',
      'image': user.photoURL,
      'uid': user.uid,});
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
    await _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
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