
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dotted_line/dotted_line.dart';
import '../../../common/Colors.dart';
import 'cart_item.dart';
import '../../../ViewController/Providers/cart_provider.dart';
import 'orders_screen.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cp = ref.watch(cartService);
    final carts = cp.carts.reversed.toList();

    return Scaffold(
      backgroundColor: fbackgroundColor1,
      appBar: AppBar(
        backgroundColor: fbackgroundColor1,
        elevation: 0,
        title: const Text(
          "My Cart",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: carts.isNotEmpty
                ? ListView.builder(
              itemCount: carts.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: CartItems(cart: carts[index]),
                );
              },
            )
                : Center(
              child: Text(
                "Your cart is empty!",
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          if (carts.isNotEmpty) _buildSummarySection(context, cp),
        ],
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context, CartProvider cp) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          // Delivery Fee
          Row(
            children: [
              const Text(
                "Delivery",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(child: DottedLine()),
              const SizedBox(width: 10),
              const Text(
                "\$4.99",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Total Cart
          Row(
            children: [
              const Text(
                "Total Order",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(child: DottedLine()),
              const SizedBox(width: 10),
              Text(
                "\$${(cp.totalCart() + 4.99).toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 22,
                  letterSpacing: -1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Place Order Button
          ElevatedButton(
            onPressed: () => _showOrderConfirmationDialog(context, cp),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text(
              "Place Order",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderConfirmationDialog(BuildContext context, CartProvider cp) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Your Order"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...cp.carts
                    .map((c) => Text("${c.productData['name']} × ${c.quantity}"))
                    .toList(),
                const SizedBox(height: 10),
                Text(
                    "Total Payable: \$${(cp.totalCart() + 4.99).toStringAsFixed(2)}"),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () async {
                try {
                  final firestore = FirebaseFirestore.instance;
                  final userId = FirebaseAuth.instance.currentUser?.uid;

                  // Save order to firestore
                  await firestore.collection("orders").add({
                    "uid": userId,
                    "items": cp.carts
                        .map((c) => {
                      "productId": c.productId,
                      "productData": c.productData,
                      "quantity": c.quantity,
                    })
                        .toList(),
                    "total": cp.totalCart() + 4.99,
                    "createdAt": FieldValue.serverTimestamp(),
                  });

                  // Clear cart
                  for (var item in cp.carts) {
                    await firestore.collection("userCart").doc(item.productId).delete();
                  }
                  cp.reset();

                  Navigator.pop(context);

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Order placed successfully! 🎉")),
                  );

                  // Navigate to OrdersScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OrdersScreen()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error placing order: $e")),
                  );
                }
              },
              child: const Text("Confirm Order"),
            ),
          ],
        );
      },
    );
  }
}
