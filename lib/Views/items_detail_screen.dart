import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterecommerceapp/Feature/CartProvider/cart_provider.dart';
import 'package:flutterecommerceapp/Providers/category_providers.dart';
import 'package:flutterecommerceapp/Views/Colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:riverpod/src/framework.dart';
import '../Feature/CartProvider/cart_order_count.dart';
import '../Feature/CartProvider/orders_screen.dart';
import '../Models/model.dart';

class ItemsDetailScreen extends ConsumerStatefulWidget {
  final String title;

  const ItemsDetailScreen({super.key, required this.title});

  @override
  ConsumerState<ItemsDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends ConsumerState<ItemsDetailScreen> {
  int currentIndex = 0;
  int selectedColorIndex = 1;
  int selectedSizeIndex = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CartProvider cp = ref.watch(cartService);
    final itemdetail = ref.watch(filterproductsprovider(widget.title));
    // Provider provider = ref.watch(favoriteProvider as ProviderListenable<Provider>);





    return itemdetail.when(
      data: (itemdetail) {
        final product = itemdetail[0];
        final finalPrice = num.parse(
          // i write a fake discout becuase no discount on my api
          (product.price * (1 - (155.0 ?? 0) / 100))
              .toStringAsFixed(2),
        );




        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,

            backgroundColor: fbackgroundColor2,
            title: Text("Detail Product"),
            actions: [
              CartOrderCount(),


              SizedBox(width: 20),
            ],
          ),

          body: ListView(
            children: [
              Container(
                color: fbackgroundColor2,
                height: size.height * 0.46,
                width: size.width,
                child: PageView.builder(
                  onPageChanged: (value) {
                    if (!mounted) return;
                    setState(() {
                      currentIndex = value;
                    });

                    //         if you provide the multiple image then
                    //         it change the image  during sliding
                  },
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,

                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Hero(
                          tag: product.images,
                          child: Image.network(
                            product.images[0],
                            height: size.height * 0.4,
                            width: size.width * 0.85,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: List.generate(
                            3,
                            (index) => AnimatedContainer(
                              duration: const Duration(microseconds: 300),
                              margin: const EdgeInsets.only(right: 4),
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index == currentIndex
                                    ? Colors.blue
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        Text(
                          "H&M",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black26,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.star, color: Colors.amber, size: 17),
                        Text("${product.creationAt}"),
                        // Text(" (${product.updatedAt})",
                        //   style:TextStyle(color:Colors.black26
                        //   ),
                        // ),
                        Spacer(),

                      ],
                    ),


                    Text(
                      product.title,
                      maxLines: 1,

                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "\$ ${product.price.toString()}.00",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.pink,
                            height: 1.5,
                          ),
                        ),

                        SizedBox(width: 5),
                        if (product.price > 100)
                          Text(
                            "\$ ${product.price + 255}.00",

                            style: const TextStyle(
                              color: Colors.black26,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.black26,
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: 15),
                    Text(
                      " Description about ${product.title} ",
                      style: TextStyle(
                        fontSize: 16,

                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        letterSpacing: -.5,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      " ${product.description}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black38,
                        letterSpacing: -.5,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),



        //  ================= Modify floating actionbutton============================



          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: Colors.white,
            elevation: 0,
            label: SizedBox(
              width: size.width * 0.9,
              child: Row(
                children: [
                  // ADD TO CART button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final productId = product.id.toString();
                        final productData = {
                          "name": product.title,  // ✅ match CartItems
                          "image": product.images.isNotEmpty ? product.images[0] : "https://via.placeholder.com/150", // ✅ add image
                          "price": product.price,
                          "discountPercentage": 0, // ✅ set default if no discount
                          "description": product.description
                        };

                        cp.addCart(
                           productId as String,
                          productData,
                        );

                        showSnackBar(
                            context, "${productData['title']} added to cart!");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.shopping_bag, color: Colors.black),
                            SizedBox(width: 5),
                            Text(
                              "ADD TO CART",
                              style: TextStyle(
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10), // spacer between buttons

                  // BUY NOW button
                  Expanded(
                    child:GestureDetector(
                      onTap: (){
                        // Pass the current product to the dialog
                        _showOrderConfirmationDialog(context, cp, {
                          'id': product.id,
                          'name': product.title, // ✅ match CartItems & Orders
                          'title': product.title,
                          'image': product.images.isNotEmpty
                              ? product.images[0]
                              : "https://via.placeholder.com/150",
                          'price': product.price,
                          'discountPercentage': 0, // or real discount if available
                          'description': product.description,
                        });


                         },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        color: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.shopping_bag, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              "BUY NOW",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),




          //  ================= Modify floating actionbutton============================
























        );
      },
      error: (err, st) {
        return Text(err.toString());
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
  void showSnackBar(BuildContext context, String s) {}
}
void _showOrderConfirmationDialog(
    BuildContext context, CartProvider cp, Map<String, dynamic> product) {

  const deliveryCharge = 4.99; //  define once

  showDialog(
    context: context,
    builder: (context) {
      final productId = product['id'] ?? product['productId'] ?? '';
      final title = product['name'] ??  product['title'] ?? 'Unknown';
      final price = product['price'] ?? 0.0;
      final description = product['description'] ?? '';
      final total = price + deliveryCharge;

      return AlertDialog(
        title: const Text("Confirm Your Order"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("$title × 1"),
              const SizedBox(height: 10),
              Text("Total Payable: \$${total.toStringAsFixed(2) }"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final firestore = FirebaseFirestore.instance;
                final userId = FirebaseAuth.instance.currentUser?.uid;

                if (userId == null) throw "User not logged in";
                const deliveryCharge = 4.99; // ✅ fixed delivery charge
                final total = price + deliveryCharge;

                // Save the single product order to Firestore
                await firestore.collection("orders").add({
                  "uid": userId,
                  "items": [
                    {
                      "productId": productId,
                      "productData": {
                        "name": title,
                        "image": product['image'] ?? "https://via.placeholder.com/150",
                        "price": price,
                        "discountPercentage": 0,
                        "description": description,

                      },
                      "quantity": 1,
                    }
                  ],
                  "deliveryCharge":deliveryCharge, ///added delivery charge
                  "total": total,
                  "createdAt": FieldValue.serverTimestamp(),
                });

                Navigator.pop(context);

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                      content: Text("Order placed successfully! 🎉  (Incl. \$${deliveryCharge.toStringAsFixed(2)} delivery")),
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

