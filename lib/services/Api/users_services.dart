import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_test/models/users.dart';

class UserServices{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = 'Users';
  String data = 'Data';

  void createUser(Map<String, dynamic> data) {
    _firestore.collection(collection).doc(data['uid']).set(data);
  }


  Future<UserModel> getUserById(String id)=> _firestore.collection(collection).doc(id).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });


}
