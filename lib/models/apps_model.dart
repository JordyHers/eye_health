import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppsModel {

  static const NAME = 'name';
  static const IMAGE = 'image';
  static const USAGE = 'usage';
  static const TYPE = 'type';


  String _usage;
  String _name;
  String _image;
  String _type;


  String get name => _name;
  String get image => _image;
  String get usage => _usage;
  String get type => _type;




  AppsModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data()[NAME];
    _usage = snapshot.data()[USAGE];
    _type = snapshot.data()[TYPE];
    _image = snapshot.data()[IMAGE];


  }
  AppsModel.fromMap(Map<String, dynamic> data) {
    _name = data['name'];
    _usage = data['usage'];
    _type = data['type'];
    _image = data['image'];

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


