// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutterecommerceapp/Feature/CartProvider/Model/cart_model.dart';
// import 'package:flutterecommerceapp/Feature/CartProvider/cart_provider.dart';
// import 'package:flutterecommerceapp/Views/Colors.dart';
// import 'package:flutterecommerceapp/Views/category_items.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
//
//
//
// class CartItems extends ConsumerStatefulWidget{
// final CartModel cart;
//   const CartItems({super.key,required this.cart});
//
//   @override
//   ConsumerState<CartItems> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends ConsumerState<CartItems>{
//
//   @override
//   Widget build(BuildContext context){
//     CartProvider cp = ref.watch(cartService);
//
//     final Size size = MediaQuery.of(context).size;
//     final price = (widget.cart.productData['price'] ?? 0).toDouble();
//     final discount = (widget.cart.productData['discountPercentage'] ?? 0).toDouble();
//     final finalPrice = num.parse((price * (1 - discount / 100)).toStringAsFixed(2));
//
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius:  BorderRadius.circular(10),
//
//       ),
//
//       height: 120,
//       width: size.width/1.1,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               SizedBox(width: 20,),
//               CachedNetworkImage(
//                 imageUrl:widget.cart.productData['image']
//                     ?? 'https://via.placeholder.com/150'
//                 ,
//                 height:120,
//                 width:100,
//                 fit:BoxFit.cover,
//                 errorWidget: (context, url, error) => Icon(Icons.error),
//               ),
// const SizedBox(width: 20,),
//               Expanded(child:
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text(
//                     widget.cart.productData['name'] ?? 'No title',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color:Colors.black,
//
//                     ),
//
//                   ),
//                   SizedBox(height: 5,),
//                   Row(
//                     children: [
//
//                       // selected color and size
//
//                       Text("Color :"),
//                       SizedBox(width: 5,),
//                       CircleAvatar(radius: 10,
//
//                       // use getColorFromName to covert string to color
//
//
//                       // backgroundColor: getColorFromName(
//                       //   // widget.cart.selectedColor
//                       //
//                       // ),),
//
//                       // const SizedBox(width: 10,),
//                       // const Text("Size :"),
//                       // Text(
//                       //   // widget.cart.selectedSize,
//                       // style: TextStyle(
//                       //   fontWeight: FontWeight.w600,
//                       //
//                       // ),
//                       // ),
//
//
//                     // ],
//                   ),
// SizedBox(height: 18,),
//                   Row(children: [
//                     Text("\$ $finalPrice",
//                     style: TextStyle(color:Colors.pink,
//                     fontSize: 22,
//                     letterSpacing: -1,
//                       fontWeight: FontWeight.bold,
//
//                     ),),
//                     SizedBox(width: 45,),
//                     Row(children: [
//                       GestureDetector(
//                         onTap:(){
//                   if(widget.cart.quantity > 1){
//                     // cp.decreaseQuantity(widget.cart.productId as String);
//
//
//                   //   ai ai ai
//                     ref.read(cartService).decreaseQuantity(widget.cart.productId);
//
//                   }
//                 },
//
//
//                         child: Container(
//                           width: 25,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               color: Colors.blue,
//                               borderRadius: BorderRadius.vertical(
//                                 top:Radius.circular(7),
//
//                               ),
//
//                             ),
//                        child: Icon(
//                          Icons.remove,
//                          size: 20,
//                          color:Colors.white
//                        ),
//
//                         ),
//
//                       ),
//                       SizedBox(width: 10,),
//
//                       Text(
//                       widget.cart.quantity.toString()
//                           ?? '0'
//                         ,
//
//
//                       style: TextStyle(
//                         color:Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//
//
//                       ),),
//                       SizedBox(width: 10,),
//
//
//                       GestureDetector(
//                         onTap: (){
//
//
//                           ref.read(cartService).addCart(
//                               widget.cart.productId,
//                               widget.cart.productData
//                           );
//
//
//
//
//
//
//
//
//                           // cp.addCart(
//                           //     widget.cart.productId as String,
//                           //     widget.cart.productData
//                           //
//                           //     // widget.cart.selectedColor,
//                           //     // widget.cart.selectedSize
//                           // );
//
//
//                         },
//
//                         child: Container(
//                           width: 25,
//                           height: 30,
//                           decoration: BoxDecoration(
//                             color: Colors.blue,
//                             borderRadius: BorderRadius.vertical(
//                               top:Radius.circular(7),
//
//                             ),
//
//                           ),
//                           child: Icon(
//                               Icons.add,
//                               size: 20,
//                               color:Colors.white
//                           ),
//
//                         ),
//
//                       ),
//
//
//
//
//
//
//
//
//                     ],)
//
//                   ],)
//                 ],
//
//               ),
//                 ],
//               )
//
//                ),
//           ],)
//         ],
//       ),
//
//     );
//
//   }
// }









//===============================NEW CART_ITEM.DART =======================
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterecommerceapp/Feature/CartProvider/Model/cart_model.dart';
import 'package:flutterecommerceapp/Feature/CartProvider/cart_provider.dart';
import 'package:flutterecommerceapp/Views/Colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartItems extends ConsumerWidget {
  final CartModel cart;
  const CartItems({super.key, required this.cart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CartProvider cp = ref.watch(cartService);

    final price = (cart.productData['price'] ?? 0).toDouble();
    final discount = (cart.productData['discountPercentage'] ?? 0).toDouble();
    final finalPrice =
    num.parse((price * (1 - discount / 100)).toStringAsFixed(2));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 120,
      child: Row(
        children: [
          const SizedBox(width: 20),
          CachedNetworkImage(
            imageUrl: cart.productData['image'] ?? 'https://via.placeholder.com/150',
            height: 120,
            width: 100,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  cart.productData['name'] ?? 'No title',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "\$ $finalPrice",
                      style: const TextStyle(
                        color: Colors.pink,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    // --- Quantity Controls ---
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ref.read(cartService).decreaseQuantity(cart.productId);
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.remove, size: 18, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          cart.quantity.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            ref.read(cartService).addQuantity(cart.productId);
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.add, size: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

