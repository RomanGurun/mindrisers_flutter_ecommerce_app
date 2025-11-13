import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterecommerceapp/common/Colors.dart';

import '../Models/model.dart';
import '../Models/products.dart';
import 'package:flutterecommerceapp/ViewController/Providers/category_providers.dart';
// import '../Providers/category_providers.dart';
import '../Views/items_detail_screen.dart';
class CuratedItems extends ConsumerStatefulWidget{

  // final String title;
  final Size size;
// final DocumentSnapshot<Object?> eCommerceItems;
  final Product product;

  const CuratedItems( {super.key,required
  this.product,
    required this.size
  });

  @override
  ConsumerState<CuratedItems> createState() => _CuratedScreenState();
}

class _CuratedScreenState extends ConsumerState<CuratedItems> {

  @override
  Widget build(BuildContext context) {


    final onlyproduct = ref.watch(onlyproductprovider);

    // final isFavorite = ref.watch(favoriteProvider).favorites.contains(product.id?.toString() ?? "");

    return onlyproduct.when(
      data:(products){
        // Find the product by title (or however you filter it)

        return SizedBox(
          height: widget.size.height * 0.35,
          child:ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            shrinkWrap: true, // important
            physics: ClampingScrollPhysics(), // optional
            itemBuilder: (context, index) {
              final product = products[index];

              //  Safe image handling
              final imageUrl = (product.images.isNotEmpty)
                  ? product.images[0]
                  : "https://placehold.co/300x300?text=No+Image";


              return
                InkWell(
                  onTap: () {
                    // Navigate to details page and pass title
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ItemsDetailScreen(
                          title: product.title,  // Pass the title here
                        ),
                      ),
                    );
                  },
                  child:   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag:product.id?.toString() ?? UniqueKey().toString(),

                        child: Container(
                          decoration:BoxDecoration(
                              borderRadius:BorderRadius.circular(8),
                              color:fbackgroundColor2,
                              image:DecorationImage(



                                image:NetworkImage(imageUrl),
                                //   i have use widget . because  widget. inside a State (or ConsumerState) because the values are defined in the widget class (CuratedItems), not in the state class (_CuratedScreenState).
                                fit: BoxFit.cover,



                              )

                          ),

                          height: widget.size.height *0.25,
                          width:  widget.size.width*0.5,

                        ),

                      ),


                      SizedBox(height: 7,),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          Text("H&M",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color:Colors.black26,

                            ),),
                          SizedBox(width:5),
                          Icon(Icons.star,
                            color:Colors.amber,
                            size: 17,
                          ),
                          Text("${product.creationAt}"),
                          // Text(" (${product.updatedAt})",
                          //
                          //   style:TextStyle(color:Colors.black26
                          //   ),
                          // ),
                        ],
                      ),


//




                      SizedBox(
                        width: widget.size.width * 0.5,
                        child :Text( product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height:1.5,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text("\$ ${product.price.toString()}.00",
                            style: TextStyle(fontWeight:FontWeight.w600,
                                fontSize: 18,
                                color: Colors.pink,
                                height: 1.5
                            ),
                          ),

                          SizedBox(width: 5,
                          ),
                          if(product.price > 100)
                            Text("\$ ${product.price +255}.00",

                              style: const TextStyle(
                                color:Colors.black26,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.black26,

                              ),

                            )

                        ],
                      ),


                    ],
                  ),

                );


            },

          ),

        );






      }, error: (Object error, StackTrace stackTrace) =>
        Center(child: Text(error.toString())
        ),

      loading: () =>
      const Center(child: CircularProgressIndicator()),



    );





  }

}


