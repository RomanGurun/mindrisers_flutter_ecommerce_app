import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutterecommerceapp/Feature/Cart/CartModel/cart_model.dart';

import 'package:flutterecommerceapp/Models/CartModel/cart_model.dart';
import 'package:flutterecommerceapp/Views/category_items.dart';
import 'package:iconsax/iconsax.dart';
import '../../../ViewController/Providers/cart_provider.dart';
import 'cart_screen.dart';


class CartOrderCount extends ConsumerStatefulWidget{

  const CartOrderCount({super.key});

  @override
  ConsumerState<CartOrderCount> createState() => _CartOrderScreenState();
}

class _CartOrderScreenState extends ConsumerState<CartOrderCount>{

  @override
  Widget build(BuildContext context){
CartProvider cp = ref.watch(cartService);

return   Stack(
  clipBehavior: Clip.none,
  children: [
    Icon(Iconsax.shopping_bag, size: 28),
    cp.carts.isNotEmpty ?
    Positioned(
      right: -3,
      top: -5,
      child: GestureDetector(
        onTap:(){
          Navigator.push(
          context,MaterialPageRoute(builder:
    (context) => const CartScreen(),),

          );
    //       MATERIALPAGEROUTE


    },

        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              cp.carts.length.toString(),

              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ):
        SizedBox()
  ],
);


  }
}








