// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/legacy.dart';
// import 'Model/cart_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final cartService =
//     ChangeNotifierProvider<CartProvider>((ref) => CartProvider());
//
// class CartProvider with ChangeNotifier{
//
//   List<CartModel> _carts = [];
//   List <CartModel> get carts => _carts;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   void reset(){
//     _carts = [];
//     notifyListeners();
//   }
//   final userId = FirebaseAuth
//   .instance.currentUser?.uid; ///to get the current user's id
//   set carts(List<CartModel> carts){
//     _carts = carts;
//     notifyListeners();
//
//   }
// //   add items to crt
// Future<void> addCart(String productId,
//     Map<String,dynamic> productData,
//     // String  selectedColor,
//     // String selectedSize
//
//     ) async{
//     int index =
//         _carts.indexWhere((elements) =>
//         elements.productId == productId);
//
//     if(index != -1){
//     //   items exists,update quantity and selected attributes
//       var existingItem = _carts[index];
//       _carts[index] = CartModel(
//         productId:productId,
//         productData :productData,
//         quantity: existingItem.quantity +1, //Increase quantity
//         // selectedColor:selectedColor, //update Selected Color
//         // selectedSize:selectedSize, //update Selected Size
//
//
//       );
//
// await _updateCartInFirebase(productId,_carts[index].quantity);
//     }else{
//     //   Items doesnot exist,add new entry
//       _carts.add(
//         CartModel(
//           productId:productId,
//           productData :productData,
//           quantity : 1, //initially one items must be required:
//           // selectedColor:  selectedColor, //update Selected Color
//           // selectedSize:selectedSize, //update Selected Size
//
//
//
//         ),
//       );
//       await _firestore.collection("userCart").doc(productId).set({
//         'productData':productData,
//         'quantity':1,
//         // 'SelectedColor':selectedColor,
//         // 'SelectedSize':selectedSize,
//         'uid':userId,
//       });
//
//     }
//
//     notifyListeners();
//
// }
//
// // incrase quantity
//   Future<void> addQuantity(String productId) async{
//     int index = _carts.indexWhere((element) => element.productId == productId);
//      _carts[index].quantity +=1;
//      await _updateCartInFirebase(productId, _carts[index].quantity);
//      notifyListeners();
//        }
//
// //        Decrease quantity or remove the items
//   Future<void> decreaseQuantity(String productId) async{
//     int index = _carts.indexWhere((element) => element.productId == productId);
//     _carts[index].quantity -=1;
//     if(_carts[index].quantity <=0){
//       _carts.removeAt(index);
// await _firestore.collection("userCart").doc(productId).delete();
//
//     }else{
//       await _updateCartInFirebase(productId, _carts[index].quantity);
//       notifyListeners();
//
//     }
//
// notifyListeners();
//
//   }
//
// // check if the product exists in the cart
//   bool productExist(String productId){
//     return _carts.any((element) =>
//     element.productId == productId);
//
//   }
// //   calculate total cart value
// //   double totalCart(){
// //     double total = 0;
// //     for(var i = 0; i< _carts.length;i ++){
// //       final finalPrice = num.parse((
// //       _carts[i].productData['price']*(1 - carts[i].productData['discountPercentage']/100
// //       )).toStringAsFixed(2));
// // total += _carts[i].quantity * (finalPrice);
// //
// //     }
// // return total;
// //     }
//
//   double totalCart() {
//     double total = 0;
//     for (var cart in _carts) {
//       final price = (cart.productData['price'] ?? 0).toDouble();
//       final discount = (cart.productData['discountPercentage'] ?? 0).toDouble();
//       final discountedPrice = price * (1 - discount / 100);
//
//       total += (cart.quantity ?? 0) * discountedPrice;
//     }
//     return total;
//   }
//
//
//
//
//
// // Load cart items from firebase (to display it
// //   in cart screen
// Future<void> loadCartItems() async{
//     try{
//       QuerySnapshot snapshot =
//           await _firestore.collection(
//             "userCart"
//           ).where("uid",isEqualTo: userId).get();
//       _carts = snapshot.docs.map((doc){
// final data = doc.data() as Map<String,dynamic>;
// return CartModel(
//   productId:doc.id,
//   productData: data['productData'],
//   quantity :data['quantity'],
//   // selectedColor : data['selectedColor'],
//   // selectedSize :data['selectedSize'],
//
// );
//       }).toList();
//
//     }catch(e){
//       print(e.toString());
//     }
// }
//
//
//
// // save orderList in fireStore
//
//
//
//
// //   remove cartitems from firestore
//   Future<void> deleteCartItem(String productId) async{
//     int index = _carts.indexWhere((element) =>
//     element.productId == productId);
//     if(index != -1){
//       _carts.removeAt(index);
//       await _firestore
//       .collection("userCart")
//       .doc(productId)
//       .delete(); ///Remove item from firestore
//
//       notifyListeners(); ///Notify listeners to update UI
//
//     }
//   }
//
//
//
//
// // update cart items in Firebase
// Future<void> _updateCartInFirebase(String productId,int quantity) async{
//     try{
//       await _firestore.collection("userCart").doc(productId).update({
//         "quantity" :quantity
//       });
//
//     }catch(e){
//       print(e.toString());
//     }
// }
// }



//AI AI AI AI AI
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'Model/cart_model.dart';

final cartService =
ChangeNotifierProvider<CartProvider>((ref) => CartProvider());

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];
  List<CartModel> get carts => _carts;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid; // current user id

  /// Reset cart
  void reset() {
    _carts = [];
    notifyListeners();
  }

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  // -------------------------------
  // Add to Cart
  // -------------------------------
  Future<void> addCart(
      String productId,
      Map<String, dynamic> productData,
      ) async {
    int index =
    _carts.indexWhere((element) => element.productId == productId);

    if (index != -1) {
      // Item exists → increase qty
      _carts[index].quantity += 1;
      await _updateCartInFirebase(productId, _carts[index].quantity);
    } else {
      // New item
      final newItem = CartModel(
        productId: productId,
        productData: productData,
        quantity: 1,
      );
      _carts.add(newItem);

      await _firestore.collection("userCart").doc(productId).set({
        'productData': productData,
        'quantity': 1,
        'uid': userId,
      });
    }

    notifyListeners();
  }

  // -------------------------------
  // Increase quantity
  // -------------------------------
  Future<void> addQuantity(String productId) async {
    int index = _carts.indexWhere((e) => e.productId == productId);
    if (index != -1) {
      _carts[index].quantity += 1;
      await _updateCartInFirebase(productId, _carts[index].quantity);
      notifyListeners();
    }
  }

  // -------------------------------
  // Decrease quantity or remove
  // -------------------------------
  Future<void> decreaseQuantity(String productId) async {
    int index = _carts.indexWhere((e) => e.productId == productId);
    if (index != -1) {
      _carts[index].quantity -= 1;

      if (_carts[index].quantity <= 0) {
        _carts.removeAt(index);
        await _firestore.collection("userCart").doc(productId).delete();
      } else {
        await _updateCartInFirebase(productId, _carts[index].quantity);
      }
      notifyListeners();
    }
  }

  // -------------------------------
  // Check if product exists
  // -------------------------------
  bool productExist(String productId) {
    return _carts.any((element) => element.productId == productId);
  }

  // -------------------------------
  // Calculate total cart value
  // -------------------------------
  double totalCart() {
    double total = 0;
    for (var cart in _carts) {
      final price = (cart.productData['price'] ?? 0).toDouble();
      final discount =
      (cart.productData['discountPercentage'] ?? 0).toDouble();
      final discountedPrice = price * (1 - discount / 100);

      total += (cart.quantity) * discountedPrice;
    }
    return total;
  }

  // -------------------------------
  // Load cart items from Firebase
  // -------------------------------
  Future<void> loadCartItems() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("userCart")
          .where("uid", isEqualTo: userId)
          .get();

      _carts = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CartModel(
          productId: doc.id,
          productData: data['productData'],
          quantity: data['quantity'],
        );
      }).toList();

      notifyListeners();
    } catch (e) {
      debugPrint("Error loading cart items: $e");
    }
  }

  // -------------------------------
  // Delete cart item
  // -------------------------------
  Future<void> deleteCartItem(String productId) async {
    int index = _carts.indexWhere((e) => e.productId == productId);
    if (index != -1) {
      _carts.removeAt(index);
      await _firestore.collection("userCart").doc(productId).delete();
      notifyListeners();
    }
  }

  // -------------------------------
  // Update cart item in Firebase
  // -------------------------------
  Future<void> _updateCartInFirebase(
      String productId, int quantity) async {
    try {
      await _firestore.collection("userCart").doc(productId).update({
        "quantity": quantity,
      });
    } catch (e) {
      debugPrint("Error updating cart: $e");
    }
  }
}
