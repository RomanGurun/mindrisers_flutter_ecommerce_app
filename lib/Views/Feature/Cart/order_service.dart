import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> placeOrder({
    required List<Map<String, dynamic>> cartItems,
    required double total,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection("orders").add({
      "uid": user.uid,
      "items": cartItems,
      "total": total,
      "createdAt": Timestamp.now(),
    });
  }
}
