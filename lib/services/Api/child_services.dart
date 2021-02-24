import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_test/models/child_model.dart';

class ChildServices{
  String collection = 'Data';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String image ="";
  String name ="";


  // Future<Map<String ,dynamic>> getUserChild({String userId}) async =>
  //     _firestore
  //         .collection(collection).doc(userId)
  //         .get()
  //         .then((value) {
  //       var children = <ChildModel>[];
  //       value.data['name']
  //       }
  //       return children;
  //     });

  // Future<String> getNumOrders(String id) async =>
  //     Firestore.instance.collection(collection).document(id).get().then((value){
  //       print(value.data["id"] + " from order value.data[id]");
  //       String order = value.data["id"] ;
  //       print(order + " from order ");
  //       return order;
  //     });

// Future<String> getNumOrders(String id)  async {
//   Firestore.instance.collection(collection).document(id).get().then((value){
//     print(value.data["id"] + " from order value.data[id]");
//     String order = value.data["id"] ;
//     print(order + " from order ");
//     return order;
//   });
// }

}