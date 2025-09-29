import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterecommerceapp/Feature/CartProvider/Model/cart_model.dart';
import 'package:flutterecommerceapp/Views/category_items.dart';



class CartItems extends ConsumerStatefulWidget{
final CartModel cart;
  const CartItems({super.key,required this.cart});

  @override
  ConsumerState<CartItems> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartItems>{

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:  BorderRadius.circular(10),

      ),

      height: 120,
      width: size.width/1.1,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 20,),
              CachedNetworkImage(
                imageUrl:cart.productData['image'],
                height:120,
                width:100,
                fit:BoxFit.cover,
              ),

               ],
          ),
        ],
      ),

    );

  }
}