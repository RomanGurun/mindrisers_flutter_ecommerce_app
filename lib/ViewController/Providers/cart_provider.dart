
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutterecommerceapp/Models/CartModel/cart_model.dart';

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
