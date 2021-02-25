import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_test/models/child_model.dart';
import 'package:eye_test/models/users.dart';


class DataRepository {
  // 1
  final CollectionReference collection = FirebaseFirestore.instance.collection('Data');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  // 3
  Future<void> addUserToData(UserModel mod) {
    return collection.doc(mod.reference.id).set(mod.toJson());
  }
  // 4
   updateMod(UserModel mod) async {
    await collection.doc(mod.reference.id).update(mod.toJson());
  }


}
