// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/legacy.dart';
// final favoriteProvider =
//     ChangeNotifierProvider<FavoriteProvider>((ref) =>
//     FavoriteProvider());
//
// class FavoriteProvider extends ChangeNotifier {
//   List<String> _favoriteIds = [];
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   List<String> get favorites => _favoriteIds;
//
//   void reset() {
//     _favoriteIds = [];
//     notifyListeners();
//   }
//
//   final userId =
//       FirebaseAuth.instance.currentUser?.uid; //get current user's ID
//   FavoriteProvider() {
//     loadFavorites();
//
//
//
//   }
//
// //   toggle favorites States
// //   void toggleFavorite(DocumentSnapshot product) async {
// //     String productId = product.id;
// //     if (_favoriteIds.contains(productId)) {
// //       _favoriteIds.remove(productId);
// //       await _removeFavorite(productId);  //remove from favorite
// //
// //     } else {
// //       _favoriteIds.add(productId);
// //       await _addFavorite(productId);
// //
// //       ///add items to favorite collection
// //
// //
// //     }
// //     notifyListeners();
// //   }
//
// //===============   gpt ======================
//
//
//   void toggleFavorite(DocumentSnapshot product) async {
//     String productId = product.id;
//     if (_favoriteIds.contains(productId)) {
//       _favoriteIds.remove(productId);
//       await _removeFavorite(productId);
//     } else {
//       _favoriteIds.add(productId);
//       await _addFavorite(productId, product.data() as Map<String, dynamic>);
//     }
//     notifyListeners();
//   }
//
//
// //===============   gpt ======================
//
//
//
//
//
//
//
//
//
//
// // check if a product is favorited
//   bool isExist(DocumentSnapshot product) {
//     return _favoriteIds.contains(product.id);
//   }
//
//
// // add favorite to firestore
// //   Future<void> _addFavorite(String productId) async {
// //     try {
// //       await _firestore.collection("userFavorite").doc(productId).set({
// //         "isFavorite": true,
// //         "userId": userId,
// //
// //       });
// //     } catch (e) {
// //       throw (e.toString());
// //     }
// //   }
//
// //===============   gpt ======================
//   Future<void> _addFavorite(String productId, Map<String, dynamic> productData) async {
//     await _firestore.collection("userFavorite").doc(productId).set({
//       "userId": userId,
//       "name": productData['name'],
//       "image": productData['image'],
//       "price": productData['price'],
//       "category": productData['category'],
//       "isFavorite": true,
//     });
//   }
//
// //===============   gpt ======================
//
//
// // Remove favorite from firestore
//   Future<void> _removeFavorite(String productId) async {
//     try {
//       await _firestore.collection("userFavorite").doc(productId).delete();
//     } catch (e) {
//       throw (e.toString());
//     }
//   }
//
//
// // to keep store and load items favorite until remove from favorite
//
//   Future<void> loadFavorites() async {
//     try {
//       QuerySnapshot snapshot = await _firestore
//           .collection("userFavorite")
//           .where('userId', isEqualTo: userId)
//           .get();
//
//       _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
//     } catch (e) {
//       throw (e.toString());
//     }
//
//
//     notifyListeners();
//   }
// }










import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final favoriteProvider =
ChangeNotifierProvider<FavoriteProvider>((ref) => FavoriteProvider());

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

// 👇 Add this line
  FirebaseFirestore get firestore => _firestore;


  List<String> get favorites => _favoriteIds;

  FavoriteProvider() {
    loadFavorites();
  }

  /// Reset local favorites list
  void reset() {
    _favoriteIds = [];
    notifyListeners();
  }

  /// Toggle favorites state
  void toggleFavorite(DocumentSnapshot product) async {
    String productId = product.id;

    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      await _removeFavorite(productId);
    } else {
      _favoriteIds.add(productId);
      await _addFavorite(productId, product.data() as Map<String, dynamic>);
    }

    notifyListeners();
  }

  // inside FavoriteProvider
  // Future<void> toggleFavoriteFromMap(String productId, Map<String, dynamic> productData) async {
  //   if (_favoriteIds.contains(productId)) {
  //     _favoriteIds.remove(productId);
  //     await _removeFavorite(productId);
  //   } else {
  //     _favoriteIds.add(productId);
  //     await _addFavorite(productId, productData);
  //   }
  //   notifyListeners();
  // }
  //

  void toggleFavoriteFromMap(String productId, Map<String, dynamic> productData) async {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      await _firestore.collection("userFavorite").doc(productId).delete();
    } else {
      _favoriteIds.add(productId);
      await _firestore.collection("userFavorite").doc(productId).set({
        "userId": userId,
        "name": productData['name'],
        "image": productData['image'],
        "price": productData['price'],
        "category": productData['category'],
        "isFavorite": true,
        "createdAt": FieldValue.serverTimestamp(),
      });
    }
    notifyListeners();
  }


  /// Check if a product is favorited
  bool isExist(DocumentSnapshot product) {
    return _favoriteIds.contains(product.id);
  }

  /// Add favorite with product details
  Future<void> _addFavorite(
      String productId, Map<String, dynamic> productData) async {
    try {
      await _firestore.collection("userFavorite").doc(productId).set({
        "userId": userId,
        "name": productData['name'],
        "image": productData['image'],
        "price": productData['price'],
        "category": productData['category'],
        "isFavorite": true,
        "createdAt": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint("Error adding favorite: $e");
    }
  }

  /// Remove favorite
  Future<void> _removeFavorite(String productId) async {
    try {
      await _firestore.collection("userFavorite").doc(productId).delete();
    } catch (e) {
      debugPrint("Error removing favorite: $e");
    }
  }

///  / Load user’s favorites
  Future<void> loadFavorites() async {
    if (userId == null) return;
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("userFavorite")
          .where('userId', isEqualTo: userId)
          .get();

      _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading favorites: $e");
    }
  }
}



//
// Future<void> loadFavorites() async {
//   if (userId == null) return;
//   final snapshot = await _firestore
//       .collection("userFavorite")
//       .where('userId', isEqualTo: userId)
//       .get();
//   _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
//   notifyListeners();
// }
// }
