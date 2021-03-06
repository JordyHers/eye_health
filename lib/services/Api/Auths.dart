import 'dart:async';
import 'dart:collection';


import 'package:app_usage/app_usage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Stream<List<UserModel>> UserStream();

  Future <bool> continueSignUp();

  Future<void> signOut();


  Future<void> reloadUserModel();
}

 class Auths with ChangeNotifier implements BaseAuth {

   final _firebaseAuth = FirebaseAuth.instance;
  List<AppUsageInfo> _infos = <AppUsageInfo> [];

  Iterable<ChildModel> childModel;
  List<AppUsageInfo> get infos => _infos;

  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  UnmodifiableListView <ChildModel> get child => UnmodifiableListView(childModel);


  final FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  Status get status => _status;
  User get user => _firebaseAuth.currentUser;

  final UserServices _userServices = UserServices();


  UserModel get currentUser => _userModel;

  UserModel _userModel = UserModel();
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


   Stream<List<UserModel>> UserStream(){
    final path = 'Data';
     final reference = FirebaseFirestore.instance.collection(path);
     final snapshots = reference.snapshots();
     /// Here snapshots returns a stream of documents
     ///available in the given path.[snapshot is a collection
     //snapshots.listen((snapshot) {

     /// Here for each document in the collection snapshot
     /// print their corresponding data [snapshot is a document]
     // snapshot.docs.forEach((snapshot) => print(snapshot.data()));

     /// Here we convert a collection snapshot into a list
     return snapshots.map((snapshot) =>  snapshot.docs.map((snapshot){
       ///then the second snapshot = document turns them into data
       final data = snapshot.data();
       print(data);
       return data != null ? UserModel(
         name: data['name'],
         surname: data['surname'],
         email: data['email'],
         image: data['image'],
         childMod:  data['childMod'],
         appsUsageModel: data['appsUsageModel'].cast<AppUsageInfo>(),
         token: data['token'],
         id: data['id'],
         reference: data['reference'],
         totalDuration: data['totalDuration']
       ) : null ;
     },).toList());

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
   Future<bool> addChild(
       {ChildModel childModel}) async {
     try {

       List<ChildModel> child = _userModel.childMod;

       var childItem = {
         'id': '123456',
         'name': childModel.name,
         'image': childModel.image,
         'reference': childModel.reference,
         'appUsageModel': _infos,
         'totalDuration':childModel.totalDuration,
         'token': childModel.token,

       };

       ChildModel item = ChildModel.fromJson(childItem);
//      if(!itemExists){
       print("ChILD ITEMS ARE: ${child.toString()}");
       _userServices.addchild(userId: _user.uid, childModel: item);
//      }
       return true;
     } catch (e) {
       print("THE ERROR ${e.toString()}");
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

  void VerifyInfoscurrentUser() async {
    _userModel = await _userServices.getUserById(user.uid);
    try {
      print('Verify user infos called \n'
          '-----------------------------------');
      print(_userModel.toJson());
    } on Exception catch (e) {
      print(' ---------------- COULD NT COMPLETE VERIFY USER INFOS');
      print(e.toString());
    }

  }

  void setTokenAndAppList() async {
    _userModel = await _userServices.getUserById(user.uid);
    try {
      await _firebaseMessaging.getToken().then((token) {
        _token = token;
        print('Device Token: $_token');
      });

      print(' _____________Auths.dart  ________________________');
      print(_userModel.appsUsageModel);
    }
    catch(e){
      print(e);
    }
  }

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






