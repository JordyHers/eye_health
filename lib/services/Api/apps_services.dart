import 'package:cloud_firestore/cloud_firestore.dart';



class AppsServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = 'Data';


  void createApps(Map<String, dynamic> data) {
    _firestore.collection(collection).doc(data['id']).set(data);
  }

  Future<List<DocumentSnapshot>> getApps()=>_firestore.collection(collection).get().then((snaps) {
    return snaps.docs;
  });
}
