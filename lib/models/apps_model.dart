

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppsModel {

  static const NAME = 'name';
  static const IMAGE = 'image';
  static const USAGE= 'usage';
  static const TYPE ='type';




  String name;
  String type;
  String usage;
  String image;




  AppsModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.data()[NAME];
    usage = snapshot.data()[USAGE];
    type = snapshot.data()[TYPE];
    image = snapshot.data()[IMAGE];


  }
  AppsModel.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    usage = data['usage'];
    type = data['type'];
    image = data['image'];

  }
  Map toMap() => {
    IMAGE: image,
    NAME: name,
    USAGE: usage,
    TYPE: type,

  };

  // Map<String, dynamic> toJson() => {
  //   'name': name,
  //   'type':  type,
  //   'usage':  usage,
  //   'image':  image,
  // };
}


