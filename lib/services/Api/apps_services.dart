import 'package:cloud_firestore/cloud_firestore.dart';

class AppsServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = 'Data/TO6fV7bVHJKEK1sSr4nr/ListOfApps';

  void createApps(Map<String, dynamic> data) {
    _firestore.collection(collection).doc(data['uid']).set(data);
  }
}
