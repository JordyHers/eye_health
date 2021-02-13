import 'package:cloud_firestore/cloud_firestore.dart';

class AppsServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = 'Data/{DataID}/ListOfApps/';

  void createApps(Map<String, dynamic> data) {
    _firestore.collection(collection).doc(data['uid']).set(data);
  }
}
