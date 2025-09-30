import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Please log in to see your orders")),
      );
    }

    final userId = user.uid;
    final userEmail = user.email ?? "No Email";

    print("Current UserId: $userId"); // DEBUG

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("uid", isEqualTo: userId)
            .snapshots(), // temporarily remove orderBy
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No orders yet."));
          }

          final orders = snapshot.data!.docs;

          print("Fetched ${orders.length} orders"); // DEBUG

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final data = order.data() as Map<String, dynamic>;
              final items = (data["items"] as List<dynamic>? ?? []);
              final total = (data["total"] ?? 0).toDouble();
              final createdAt = data["createdAt"] != null
                  ? (data["createdAt"] as Timestamp).toDate()
                  : null;

              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #${order.id.substring(0, 6)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "User: $userEmail",
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Placed on: ${createdAt != null ? createdAt.toString().split(".")[0] : "Unknown"}",
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const Divider(),
                      if (items.isNotEmpty)
                        ...items.map((item) {
                          final p = item["productData"] as Map<String, dynamic>? ?? {};
                          final name = p["name"] ?? "Unknown";
                          final qty = item["quantity"] ?? 0;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text("• $name × $qty"),
                          );
                        }),
                      if (items.isEmpty)
                        const Text("No items in this order"),
                      const Divider(),
                      Text(
                        "Total: \$${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
