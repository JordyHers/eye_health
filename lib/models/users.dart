import 'package:cloud_firestore/cloud_firestore.dart';
//import 'cart_item.dart';


class UserModel {
  static const NAME = "name";
  static const ID = "uid";
  static const SURNAME = "surname";
  static const TELEPHONE = "telephone";
  static const ADDRESS= "address";
  static const IMAGE ="image";
  static const EMAIL = "email";
  //static const CART = "cart";


  String name;
  String surname;
  String telephone;
  String address;
  String id;
  String email;
  String image;
 // int _priceSum = 0;



  UserModel();

//  getters
//   String get name => _name;
//   String get surname => _surname;
//   String get telephone => _telephone;
//   String get address => _address;
//   String get id => _id;
//   String get email => _email;
  //String get image => image;


  // public variables

  // public variables
  //List<CartItemModel> cart;
  //int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.data()[ID];
    name = snapshot.data()[NAME];
    surname = snapshot.data()[SURNAME];
    telephone= snapshot.data()[TELEPHONE];
    address = snapshot.data()[ADDRESS];
    email = snapshot.data()[EMAIL];
    image = snapshot.data()[IMAGE];
    //cart = _convertCartItems(snapshot.data[CART]?? []);
    //totalCartPrice = snapshot.data[CART] == null ? 0 :getTotalPrice(cart: snapshot.data[CART]);

  }
  UserModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
   name = data['name'];
   surname = data['surname'];
   image = data['image'];
   telephone= data['telephone'];
   email = data['email'];

  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'surname': surname,
      'telephone': telephone,
      'email': email,
      'address':address,
    };
  }
  // List<CartItemModel> _convertCartItems(List cart){
  //   List<CartItemModel> convertedCart = [];
  //   for(Map cartItem in cart){
  //     convertedCart.add(CartItemModel.fromMap(cartItem));
  //   }
  //   return convertedCart;
  // }

  // int getTotalPrice({List cart}){
  //   if(cart == null){
  //     return 0;
  //   }
  //   for(Map cartItem in cart){
  //     _priceSum += cartItem["price"] * cartItem["amount"];
  //   }
  //   int total = _priceSum;
  //   return total;
  // }

}
