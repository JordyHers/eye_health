import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_test/models/apps_model.dart';
import 'package:uuid/uuid.dart';

class AppsServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = 'Data';
  String document ='TO6fV7bVHJKEK1sSr4nr';

  void createApps(Map<String, dynamic> data) {
    _firestore.collection(collection).doc(data['id']).set(data);
  }

  Future<List<DocumentSnapshot>> getApps()=>_firestore.collection(collection).get().then((snaps) {
    return snaps.docs;
  });
}
