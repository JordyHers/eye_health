

import 'dart:ffi';

import 'package:app_usage/app_usage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class AppsUsageModel {

  static const NAME = 'name';
  static const STARTDATE = 'startDate';
  static const USAGEINSECONDS = 'usage';
  static const ENDDATE ='endDate';


  Double usageInSeconds;
  String name;
  DateTime startDate,endDate;

  DocumentReference reference;

  AppsUsageModel  ({
    this.usageInSeconds,this.name,this.startDate,this.endDate
  }) : super();


  factory AppsUsageModel .fromJson(dynamic json) => AppsUsageModel (
    usageInSeconds: json['usageInSeconds'],
    name: json ['name'],
    startDate: json['startDate'],
    endDate: json['endDate'],

  );
  dynamic toJson() => {
    'name': name,
    'usageInSeconds': usageInSeconds,
    'startDate': startDate,
    'endDate': endDate
  };





  // AppsUsageModel .fromSnapshot(DocumentSnapshot snapshot) {
  //   name = snapshot.data()[NAME];
  //   usageInSeconds = snapshot.data()[USAGEINSECONDS];
  //   startDate = snapshot.data()[STARTDATE];
  //   endDate = snapshot.data()[ENDDATE];
  //
  //
  // }
  // AppsUsageModel .fromMap(Map<String, dynamic> data) {
  //   name = data['name'];
  //   usageInSeconds = data['usageInSeconds'];
  //   startDate = data['startDate'];
  //   endDate = data['endDate'];
  //
  // }
  // Map toMap() => {
  //   NAME: name,
  //   USAGEINSECONDS: usageInSeconds,
  //   STARTDATE: startDate,
  //   ENDDATE:endDate
  //
  // };

// Map<String, dynamic> toJson() => {
//   'name': name,
//   'type':  type,
//   'usage':  usage,
//   'image':  image,
// };
}


