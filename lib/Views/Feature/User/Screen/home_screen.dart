
import 'package:flutter/material.dart';
import 'package:flutterecommerceapp/Views/Feature/User/Screen/user_login_screen.dart';
import 'package:flutterecommerceapp/Routes/app_routes.dart';
import 'package:flutterecommerceapp/Views/Feature/Cart/orders_screen.dart';
import '../../Cart/orders_screen.dart';
import '../../../../ViewController/Repository/Service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

AuthMethod authMethod = AuthMethod();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authMethod.signOut();
              NavigationHelper.pushReplacement(
                  context, const UserLoginScreen());
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  Display logged-in email
            Text(
              "Welcome, ${user?.email ?? "Guest"}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            //  Navigate to Orders Screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const OrdersScreen(),
                  ),
                );


              },
              child: const Text("My Orders"),
            ),
          ],
        ),
      ),
    );
  }
}

