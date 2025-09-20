import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterecommerceapp/Views/category_items.dart';
import 'package:flutterecommerceapp/Views/items_detail_screen.dart';
import 'package:flutterecommerceapp/Wigdets/curated_items.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutterecommerceapp/Wigdets/banner.dart';
import 'package:riverpod/src/framework.dart';
import '../Models/category_model.dart';
import '../Models/model.dart';
import 'package:flutterecommerceapp/Views/items_detail_screen.dart';
// import 'package:/pages/widgets/category_item.dart';
import 'package:flutterecommerceapp/Providers/category_providers.dart';
import 'package:flutterecommerceapp/Models/products.dart';






class AppHomeScreen extends ConsumerStatefulWidget{

  const AppHomeScreen({super.key});

  @override
  ConsumerState<AppHomeScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends ConsumerState<AppHomeScreen>{

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    final productState = ref.watch(categoryproductprovider);

          final onlyproduct = ref.watch(onlyproductprovider);


    return Scaffold(
      backgroundColor: Colors.white,

      body: productState.when(
        data: (data){
          return SingleChildScrollView(

            child: Column(

              children: [
                SizedBox(height: 30,),

                Padding(

                  padding: EdgeInsets.symmetric(horizontal: 20),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(""
                          "assets/logo.webp",
                        height: 40,),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            Iconsax.shopping_bag,
                            size:28,

                          ),
                          Positioned(
                              right: -3,
                              top:-5,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,

                                ),
                                child: Center(
                                  child: Text(
                                    "3",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,

                                    ),
                                  ),
                                ),

                              )),

                        ],
                      )
                    ],),
                ),
                SizedBox(height: 20,),
                MyBanner(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:20,
                      vertical: 18),
                  child: Row(
                    // create a space between a child widgets

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shop By Category",
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 0,
                          color:Colors.black87,
                          fontWeight: FontWeight.w600,

                        ),),
                      Text("See All",style:  TextStyle(
                        fontSize: 16,
                        letterSpacing: 0,
                        color:Colors.black45,

                      ),),


                    ],
                  ),
                ),

                // for Category
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(data.length,(index)
                    {
                      final cat = data[index];

                      return InkWell(
                        onTap: () {
                          // filter products based on the selected category


                          final filterItems = fashionEcommerceApp
                              .where((item) =>
                          item.category.toLowerCase() ==
                              category[index].name.toLowerCase())
                              .toList();

                          //   Navigate to the categoryItems screen with

                          Navigator.push(context, MaterialPageRoute(
                              builder: (_) =>
                                  CategoryItems(
                                      categoryy: cat.slug,
                                      )
                          ),
                          );
                        },

                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                  cat.image,

                                ),

                              ),

                            ),
                            const SizedBox(height: 10,),
                            Text(cat.name),
                          ],
                        ),


                      );



                    }),

                  ),
                ),


                Padding(
                  padding: EdgeInsets.symmetric(horizontal:20,
                      vertical: 18),
                  child: Row(
                    // create a space between a child widgets

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Curated For You",
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 0,
                          color:Colors.black87,
                          fontWeight: FontWeight.w600,

                        ),),
                      Text("See All",style:  TextStyle(
                        fontSize: 16,
                        letterSpacing: 0,
                        color:Colors.black45,

                      ),),


                    ],
                  ),
                ),
                // for Curated items

                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: size.height * 0.35, // fixed height for horizontal list
                    child: CuratedItems(size: size),
                  ),
                ),

                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //
                //   child: onlyproduct.when(
                //     data :(products) =>Row(
                //     children: List.generate(
                //         products.length,
                //             (index){
                //           final eCommerceItems = products[index];
                //
                //
                //           return Padding(padding:
                //           index == 0 ? EdgeInsets.symmetric(horizontal: 20):
                //           EdgeInsets.only(right:20),
                //             child: InkWell(
                //               onTap:(){
                //                 Future.delayed(Duration(milliseconds: 120),(){
                //                   if(!mounted) return;
                //                   Navigator.push(
                //                     context,
                //
                //                     MaterialPageRoute(builder: (_)=>
                //                         ItemsDetailScreen(
                //                          title:eCommerceItems.title,
                //                         ),
                //                     ),
                //                   );
                //
                //                 });
                //
                //
                //
                //               },
                //               // child:CuratedItems(size:size) ,
                //             ),
                //
                //
                //           );
                //         }),
                //   ), error: (Object error, StackTrace stackTrace) {
                //     Text("Error: $error");
                //
                //   }, loading: () {
                //       Center(child: CircularProgressIndicator());
                //
                //   },
                //   ),
                //
                //
                //
                // ),




              ],
            ),
          );

        },
        error: (err, st){
          return Text(err.toString());
        },
        loading: () => const Center(child: CircularProgressIndicator(),
        ),
      ),

    );


  }
}