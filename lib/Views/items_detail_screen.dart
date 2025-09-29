import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterecommerceapp/Feature/CartProvider/cart_provider.dart';
import 'package:flutterecommerceapp/Providers/category_providers.dart';
import 'package:flutterecommerceapp/Views/Colors.dart';
import 'package:iconsax/iconsax.dart';
import '../Feature/CartProvider/cart_order_count.dart';
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
    CartProvider cp = ref.watch(CartService);
    final itemdetail = ref.watch(filterproductsprovider(widget.title));
    FavoriteProvider provider = ref.watch(favoriteProvider);

    final finalPrice = num.parse(
      (widget.productItems['price'] *
              (1 - widget.productItems['discountPercentage'] / 100))
          .toStringAsFixed(2),
    );

    return itemdetail.when(
      data: (itemdetail) {
        final product = itemdetail[0];

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,

            backgroundColor: fbackgroundColor2,
            title: Text("Detail Product"),
            actions: [
              CartOrderCount(),

              // Stack(
              //   clipBehavior: Clip.none,
              //   children: [
              //     Icon(Iconsax.shopping_bag, size: 28),
              //     Positioned(
              //       right: -3,
              //       top: -5,
              //       child: Container(
              //         padding: EdgeInsets.all(4),
              //         decoration: BoxDecoration(
              //           color: Colors.red,
              //           shape: BoxShape.circle,
              //         ),
              //         child: Center(
              //           child: Text(
              //             "3",
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

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

                        Icon(Icons.favorite_border),
                      ],
                    ),

                    //
                    // SizedBox(
                    //   width: widget.size.width * 0.5,
                    //   child :Text( widget.eCommerceItems.name,
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 16,
                    //     height:1.5,
                    //   ),
                    //   ),
                    // ),
                    //             Row(
                    //               children: [
                    //                 Text("\$ ${widget.eCommerceItems.price.toString()}.00",
                    //                 style: TextStyle(fontWeight:FontWeight.w600,
                    //                 fontSize: 18,
                    //                   height: 1.5
                    //                 ),
                    //                 ),
                    //
                    // SizedBox(width: 5,
                    // ),
                    //
                    //               ],
                    //             ),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width / 2.1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //   for color
                              Text(
                                "Color",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // SingleChildScrollView(
                              //   scrollDirection: Axis.horizontal,
                              //   child: Row(
                              //     children:widget.eCommerceApp.fcolor.
                              //     asMap().entries
                              //         .map((entry){
                              //       final int index = entry.key;
                              //       final color = entry.value;
                              //
                              //       return Padding(
                              //         padding: EdgeInsets.only(
                              //             top:10
                              //             ,right:10)
                              //         ,
                              //         child: CircleAvatar(
                              //           radius: 18,
                              //           backgroundColor: color,
                              //           child: InkWell(
                              //             onTap: (){
                              //               setState(() {
                              //                 selectedColorIndex = index;
                              //
                              //               });
                              //             },
                              //
                              //             child: Icon(Icons.check,
                              //               color: selectedColorIndex == index ?
                              //               Colors.white :
                              //               Colors.transparent,),
                              //           ),
                              //
                              //
                              //         ),
                              //
                              //
                              //       );
                              //
                              //     }).toList(),
                              //   ),
                              // )
                            ],
                          ),
                        ),

                        //     for Size

                        // SizedBox(
                        //   width: size.width /2.4,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       //   for color
                        //       Text("Size",
                        //         style: TextStyle(
                        //           color: Colors.black54,
                        //           fontWeight: FontWeight.w500,
                        //
                        //
                        //         ),
                        //       ),
                        //       SingleChildScrollView(
                        //         scrollDirection: Axis.horizontal,
                        //         child: Row(
                        //           children:widget.eCommerceApp.size.
                        //           asMap().entries
                        //               .map((entry){
                        //             final int index = entry.key;
                        //             final String size = entry.value;
                        //
                        //             return GestureDetector(
                        //               onTap: (){
                        //                 setState(() {
                        //                   selectedSizeIndex = index;
                        //
                        //                 });
                        //               },
                        //
                        //
                        //               child: Container(
                        //                 margin: EdgeInsets.only(right: 10,top:10),
                        //                 height: 35,
                        //                 width: 35,
                        //                 decoration: BoxDecoration(
                        //                   shape: BoxShape.circle,
                        //                   color: selectedSizeIndex == index
                        //                       ? Colors.black :
                        //                   Colors.white,
                        //                   border:Border.all(
                        //                     color: selectedSizeIndex == index
                        //                         ? Colors.black :
                        //                     Colors.black12,
                        //                   ),
                        //
                        //                 ),
                        //                 child:  Center(
                        //                   child:  Text(
                        //                     size,
                        //                     style:  TextStyle(
                        //                       fontWeight: FontWeight.bold,
                        //                       color : selectedSizeIndex == index
                        //                           ? Colors.white :
                        //                       Colors.black,
                        //
                        //                     ),
                        //
                        //
                        //                   ),
                        //                 ),
                        //
                        //
                        //
                        //               ),
                        //             );
                        //
                        //           }).toList(),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: Colors.white,
            elevation: 0,

            label: SizedBox(
              width: size.width * 0.9,

              child: Row(
                children: [





                     Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),

                        child: GestureDetector(
    onTap: () {
      final productId = widget.productItems.id; //to get doc id
      final productData =
      widget.productItems.data() as Map<String, dynamic>;
      //get product data as a to get currrently selected color ans size

      final selectedColor =
      widget.productItems['fcolor'][selectedColorIndex];
      final selectedSize =
      widget.productItems['fsize'][selectedColorIndex];
      // call the service function

      cp.addCart(
        productId,
        productData,
        selectedColor,
        selectedSize,
      );

      //   notify to user
      showSnackBar(
          context, "${productData['name']} added to cart!"
      );
    },

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
                        ],
                  ),
                  SizedBox(width: 10),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      color: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.shopping_bag, color: Colors.black),
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

                      // child: Center(
                      //   child: Text(
                      //     "BUY NOW",
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       letterSpacing: -1,
                      //
                      //     ),
                      //   ),
                      // )
                    ),
                  ),
                      // ],
              ),
            ),

        );
      },
      error: (err, st) {
        return Text(err.toString());
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
