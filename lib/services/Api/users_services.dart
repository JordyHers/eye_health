import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_test/models/child_model.dart';
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
  void addchild({String userId, ChildModel childModel}){
    _firestore.collection('Data').doc(userId).update({
      'childModel': FieldValue.arrayUnion([childModel.toJson()])
    });
  }

  Future<UserModel> getUserchild(String id)=> _firestore.collection(collection).doc(id).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });







}
