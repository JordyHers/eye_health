import 'package:cloud_firestore/cloud_firestore.dart';

import 'apps_model.dart';
//import 'cart_item.dart';

class UserModel {
  static const NAME = 'name';
  static const ID = 'uid';
  static const SURNAME = 'surname';
  static const TELEPHONE = 'telephone';
  static const ADDRESS = 'address';
  static const IMAGE = 'image';
  static const EMAIL = 'email';
  static const APPS = 'apps';

  String name;
  String surname;
  String telephone;
  String address;
  String id;
  String email;
  String image;
  List<AppsModel> apps;

  UserModel();

//  getters
//   String get name => _name;
//   String get surname => _surname;
//   String get telephone => _telephone;
//   String get address => _address;
//   String get id => _id;
//   String get email => _email;
  //String get image => image;

  // public variables

  // public variables

  //int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.data()[ID];
    name = snapshot.data()[NAME];
    surname = snapshot.data()[SURNAME];
    telephone = snapshot.data()[TELEPHONE];
    address = snapshot.data()[ADDRESS];
    email = snapshot.data()[EMAIL];
    image = snapshot.data()[IMAGE];
    apps = snapshot.data()[APPS];
    //totalCartPrice = snapshot.data[CART] == null ? 0 :getTotalPrice(cart: snapshot.data[CART]);
  }
  UserModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    surname = data['surname'];
    image = data['image'];
    telephone = data['telephone'];
    email = data['email'];
    apps = data['apps'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'surname': surname,
      'telephone': telephone,
      'email': email,
      'address': address,
      'apps' : apps,
    };
  }
}
