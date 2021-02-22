
import 'package:app_usage/app_usage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_test/models/child_model.dart';




class UserModel {

  String name;
  String surname;
  String id;
  String email;
  String image;
  String token;
  int totalDuration;


  String get displayName => [name, surname].join(' ').trim();
  List<ChildModel> childMod = <ChildModel>[];
  List<AppUsageInfo> appsUsageModel = <AppUsageInfo>[];
  DocumentReference reference;

  UserModel(this.name, {this.surname, this.id, this.email, this.reference,  this.token,this.image,  this.appsUsageModel, this.totalDuration,this.childMod});

  factory UserModel.fromJson(Map<String, dynamic> json) =>_UserModelFromJson(json);


  dynamic toJson() =>
      {
        'id': id,
        'name': name,
        'token': token.toString() ?? 'No Token Available',
        'surname': surname,
        'email': email,
        'reference': reference,
        'image': image,
        'appsUsageModel': appsList(appsUsageModel ) ?? [] ,
        'totalDuration': totalDuration,
        'childModel' : childMod,
      };

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
   // totalDuration = snapshot.data()['usage'] == null ? 0 :getFullUsage(apps: snapshot.data()['usage']);
    var mod = UserModel.fromJson(snapshot.data());
    mod.reference = snapshot.reference;
    return mod;

  }

  UserModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    surname = data['surname'];
    image = data['image'];
    email = data['email'];
    appsUsageModel = data['apps'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'surname': surname,
      'email': email,
      'apps': appsUsageModel,
    };
  }




}
UserModel _UserModelFromJson (dynamic json) {
  return   UserModel(
    json['name'] as String,
    id: json['id'] as String,
    token: json['token'] as String,
    surname: json['surname'] as String ,
    email: json['email'] as String,
    reference: json['reference'],
    image: json['image'],
    appsUsageModel: _convertModel(json['appsUsageModel'] as List ?? []) ,
    childMod: _convertChildren(json['childMod'] as List ?? [] ) ,
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
List<ChildModel> _convertChildren(List<dynamic> childMod) {
  if (childMod == null) {
    return null;
  }
  var kids = <ChildModel>[];
  childMod.forEach((value) {
    kids.add(ChildModel.fromJson(value));
  });
  return kids;
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




