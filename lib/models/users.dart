

import 'package:app_usage/app_usage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_test/services/Api/Auths.dart';
import 'package:provider/provider.dart';


class DataRepository {
  // 1
  final CollectionReference collection = FirebaseFirestore.instance.collection('Data');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  // 3
  Future<DocumentReference> addUser(UserModel mod) {
    return collection.add(mod.toJson());
  }
  // 4
  updateMod(UserModel mod, List<AppUsageInfo> apps) async {
     mod.appsUsageModel = apps ;
   await collection.doc(mod.reference.id).update(mod.toJson());
  }
}

class UserModel {

  String name;
  String surname;
  String telephone;
  String address;
  String id;
  String email;
  String image;

  List<AppUsageInfo> appsUsageModel = <AppUsageInfo>[];
  DocumentReference reference;

  UserModel(this.name, {this.surname, this.telephone, this.address, this.id, this.email, this.reference,  this.image,  this.appsUsageModel});

  factory UserModel.fromJson(Map<String, dynamic> json) =>_UserModelFromJson(json);


  dynamic toJson() =>
      {
        'id': id,
        'name': name,
        'surname': surname,
        'telephone': telephone,
        'email': email,
        'address': address,
        'reference': reference,
        'image': image,
        'appsUsageModel': appsList(appsUsageModel),
      };

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    var mod = UserModel.fromJson(snapshot.data());
    mod.reference = snapshot.reference;
    return mod;
    // id = snapshot.data()[ID];
    // name = snapshot.data()[NAME];
    // surname = snapshot.data()[SURNAME];
    // telephone = snapshot.data()[TELEPHONE];
    // address = snapshot.data()[ADDRESS];
    // email = snapshot.data()[EMAIL];
    // image = snapshot.data()[IMAGE];
    // appsUsageModel = _convertAppItems(snapshot.data()[APPS]?? []);
    //totalCartPrice = snapshot.data[CART] == null ? 0 :getTotalPrice(cart: snapshot.data[CART]);
  }

  UserModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    surname = data['surname'];
    image = data['image'];
    telephone = data['telephone'];
    email = data['email'];
    appsUsageModel = data['apps'];
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
      'apps': appsUsageModel,
    };
  }



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
// List<AppsUsageModel> _convertAppItems(List apps){
//   var convertedApps = <AppsUsageModel>[];
//   for(Map _apps in apps){
//     convertedApps.add(AppUsageInfo.fromMap(_apps));
//   }
//   return convertedApps;
// }

UserModel _UserModelFromJson (dynamic json) {
  return   UserModel(
    json['name'] as String,
    id: json['id'] as String,
    surname: json['surname'] as String,
    telephone: json['telephone'] as String,
    address: json['address'] as String,
    email: json['email'] as String,
    reference: json['reference'],
    image: json['image'],
    appsUsageModel: _convertModel(json['appsUsageModel'] as List),
  );
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

