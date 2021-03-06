


import 'package:app_usage/app_usage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class ChildModel {

  String name;
  String surname;
  String id;
  Position position;
  String image;
  String token;
  int totalDuration;

  String get displayName => [name, surname].join(' ').trim();

  List<AppUsageInfo> appsUsageModel = <AppUsageInfo>[];
  DocumentReference reference;

  ChildModel(
      {this.name,this.surname, this.id, this.reference, this.token, this.image, this.appsUsageModel, this.totalDuration,this.position});

  factory ChildModel.fromJson(Map<String, dynamic> json) =>
      _ChildModelFromJson(json);


  dynamic toJson() =>
      {
        'id': id,
        'name': name,
        'token': token.toString() ?? 'No Token Available',
        'surname': surname,
        'reference': reference,
        'image': image,
        'position':position,
        'appsUsageModel': appsList(appsUsageModel),
        'totalDuration': totalDuration
      };

  factory ChildModel.fromSnapshot(DocumentSnapshot snapshot) {
    // totalDuration = snapshot.data()['usage'] == null ? 0 :getFullUsage(apps: snapshot.data()['usage']);
    var mod = ChildModel.fromJson(snapshot.data());
    mod.reference = snapshot.reference;
    return mod;
  }


}
  ChildModel _ChildModelFromJson (dynamic json) {
    return   ChildModel(
      name:json['name'] as String,
      id: json['id'] as String,
      token: json['token'] as String,
      surname: json['surname'] as String ,
      reference: json['reference'],
      image: json['image'],
      position: json['position'],
      appsUsageModel: _convertModel(json['appsUsageModel'] as List ) ?? [],
      totalDuration : json['totalDuration'] == null ? 0 : getFullUsage(json['appUsageModel']),

    );
  }

  List<Map<String, dynamic>> appsList(List<AppUsageInfo> apps) {
    if (apps == null) {
      return null;
    }
    var appsMap = <Map<String, dynamic>>[];
    apps.forEach((value) {
      appsMap.add(value.toJson());
    });
    return appsMap;

  }


  List<AppUsageInfo> _convertModel(List<dynamic> appsMod) {
    if (appsMod == null) {
      return null;
    }
    var apps = <AppUsageInfo>[];
    appsMod.forEach((value) {
      apps.add(AppUsageInfo.fromJson(value));
    });
    return apps;
  }
  int getFullUsage(List<dynamic> apps){
    var Sum =0;
    if(apps == null){
      return 0;
    }
    for(Map appsItem in apps){
      Sum += appsItem['usage'] + appsItem['usage'] ;
      print('Sum-----------------');
      print(Sum);
    }
    var total = Sum;
    return total;
  }




