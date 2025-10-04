import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterecommerceapp/Feature/User/Screen/home_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutterecommerceapp/Views/app_home_screen.dart';

import '../Feature/CartProvider/cart_order_count.dart';
import '../Feature/CartProvider/cart_screen.dart';

class AppMainScreen extends ConsumerStatefulWidget{

  const AppMainScreen({super.key});

  @override
  ConsumerState<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends ConsumerState<AppMainScreen>{

  int selecetedIndex =0;
  final List pages = [
    const AppHomeScreen(),

    const CartScreen(),

    const HomeScreen(),



  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black38,
        selectedItemColor: Colors.black,
        type:BottomNavigationBarType.fixed,
       currentIndex: selecetedIndex,
        onTap:(value){
          setState((){

          });

selecetedIndex = value;
        },
        elevation: 0,
        backgroundColor: Colors.white,
        items:const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home),label :"Home"),
          BottomNavigationBarItem(icon: Icon(Iconsax.shopping_cart),label :"Cart"),
       BottomNavigationBarItem(icon: Icon(Icons.person_outline),label:"Account"),

        ],
      ),
      body: pages[selecetedIndex],
    );
  }
}