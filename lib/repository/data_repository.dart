import 'package:app_usage/app_usage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_test/models/users.dart';


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

  Future <void> updateMod(UserModel mod) async {
    await collection.doc(mod.reference.id).update(mod.toJson());
  }


}
