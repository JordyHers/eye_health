import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_test/models/users.dart';

class UserServices{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = 'Users';


  void createUser(Map<String, dynamic> data) {
    _firestore.collection(collection).doc(data['uid']).set(data);
  }

  Future<UserModel> getUserById(String id)=> _firestore.collection(collection).doc(id).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });


  // Future<UserModel> getUserChild(UserModel model){
  //
  //   _firestore.collection(collection).doc(model.reference.id).get().then((doc){
  //     Map<String, Object> child=  doc.get('ChildModel');
  //     return ChildModel.fromSnapshot(doc);
  // });
  //
  // }


}
