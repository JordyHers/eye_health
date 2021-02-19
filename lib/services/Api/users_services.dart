import 'dart:async';

import 'package:app_usage/app_usage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_test/models/users.dart';

class UserServices{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = 'Users';
  String data = 'Data';

  void createUser(Map<String, dynamic> data) {
    _firestore.collection(collection).doc(data['uid']).set(data);
  }
  void addToList({String userId, List <AppUsageInfo> appsItem}) {
    // print('Last list of apps before upload');
    // print('---------------------------------------------------------------------\n');
    // print(appsItem);
    // print('---------------------------------------------------------------------\n');
  }

  Future<UserModel> getUserById(String id)=> _firestore.collection(collection).doc(id).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });
  // void addToCart({String userId, CartItemModel cartItem}){
  //   _firestore.collection(collection).document(userId).updateData({
  //     "cart": FieldValue.arrayUnion([cartItem.toMap()])
  //   });
  // }

  // void removeFromCart({String userId, CartItemModel cartItem}){
  //   _firestore.collection(collection).document(userId).updateData({
  //     "cart": FieldValue.arrayRemove([cartItem.toMap()])
  //   });
  // }

}
