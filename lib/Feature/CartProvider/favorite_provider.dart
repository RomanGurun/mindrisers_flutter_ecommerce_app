import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
final favoriteProvider =
    ChangeNotifierProvider<FavoriteProvider>((ref) =>
    FavoriteProvider());

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> get favorites => _favoriteIds;

  void reset() {
    _favoriteIds = [];
    notifyListeners();
  }

  final userId =
      FirebaseAuth.instance.currentUser?.uid; //get current user's ID
  FavoriteProvider() {
    loadFavorites();



  }

//   toggle favorites States
  void toggleFavorite(DocumentSnapshot product) async {
    String productId = product.id;
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      await _removeFavorite(productId);  //remove from favorite

    } else {
      _favoriteIds.add(productId);
      await _addFavorite(productId);

      ///add items to favorite collection


    }
    notifyListeners();
  }

// check if a product is favorited
  bool isExist(DocumentSnapshot product) {
    return _favoriteIds.contains(product.id);
  }


// add favorite to firestore
  Future<void> _addFavorite(String productId) async {
    try {
      await _firestore.collection("userFavorite").doc(productId).set({
        "isFavorite": true,
        "userId": userId,

      });
    } catch (e) {
      throw (e.toString());
    }
  }


// Remove favorite from firestore
  Future<void> _removeFavorite(String productId) async {
    try {
      await _firestore.collection("userFavorite").doc(productId).delete();
    } catch (e) {
      throw (e.toString());
    }
  }


// to keep store and load items favorite until remove from favorite

  Future<void> loadFavorites() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("userFavorite")
          .where('userId', isEqualTo: userId)
          .get();

      _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      throw (e.toString());
    }


    notifyListeners();
  }
}
