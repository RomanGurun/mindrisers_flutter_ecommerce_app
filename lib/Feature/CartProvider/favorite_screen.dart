// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutterecommerceapp/Feature/CartProvider/Model/cart_model.dart';
// import 'package:flutterecommerceapp/Feature/CartProvider/cart_provider.dart';
// import 'package:flutterecommerceapp/Feature/CartProvider/favorite_provider.dart';
// import 'package:flutterecommerceapp/Views/Colors.dart';
// import 'package:flutterecommerceapp/Views/category_items.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
//
//
//
// class FavoriteScreen extends ConsumerStatefulWidget{
//   const FavoriteScreen({super.key});
//
//   @override
//   ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
// }
//
// class _FavoriteScreenState extends ConsumerState<FavoriteScreen>{
//
//   @override
//   Widget build(BuildContext context){
//
//     final userId = FirebaseAuth.instance.currentUser?.uid;
//     final provider = ref.watch(favoriteProvider);
//
// return Scaffold(
//   backgroundColor: fbackgroundColor1,
//   appBar: AppBar(
//     backgroundColor: fbackgroundColor2,
//     centerTitle: true,
//     title: const Text(
//       "Favorite",
//       style: TextStyle(
//         fontWeight:FontWeight.bold,
//
//       ),
//     ),
//
//   ),
// body: userId == null? Center(
//   child: Text("Please log-in to vew favorite"),
// ):StreamBuilder(stream:
//
//     FirebaseFirestore.instance.collection("userFavorite")
//     .where("userId",isEqualTo:userId).snapshots(),
//      builder: (context,snapshot){
//
//   if(!snapshot.hasData){
//     return const Center(child:CircularProgressIndicator());
//   }
//   final favoriteDocs = snapshot.data!.docs;
//   if(favoriteDocs.isEmpty){
//     return const Center(
//       child: Text("No favorits yet"),
//     );
//   }
//
//   return FutureBuilder<List<DocumentSnapshot>>(
//       future: Future.wait(
//         favoriteDocs.map(
//             (doc) => FirebaseFirestore.instance
//                 .collection('items')
//                 .doc(doc.id).get(),
//         )
//       ),builder:
//   (context,snapshot){
//         if(!snapshot.hasData){
//           return const Center(child:CircularProgressIndicator());
//         }
//         final favoriteItems =
//             snapshot.data!.where((doc) => doc.exists).toList();
//         if(favoriteItems.isEmpty){
//           return const Center(child: CircularProgressIndicator(),);
//
//         }return ListView.builder(
//           itemCount:favoriteItems.length,
//           itemBuilder: (context,index,
//         ){
// final favoriteItem = favoriteItems[index];
// return GestureDetector(
//   onTap: (){
//     // provider.toggleFavorite(favoriteDocs[index]); // instead of favoriteItem
//
//   },
//   child: Stack(
//     children: [
//       Padding(padding:EdgeInsets.symmetric(
//         horizontal: 15,
//         vertical: 5,
//
//       ),
//       child: Container(
//         padding: EdgeInsets.all(10),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.white,
//
//         ),
//
//         child: Row(children: [
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               color:Colors.white,
//               borderRadius: BorderRadius.circular(20),
// image: DecorationImage(
//
//     fit: BoxFit.cover,
//     image: CachedNetworkImageProvider(
//   favoriteItem['image'],
//
// ),),
//             ),
//
//
//           ),
//           SizedBox(width: 10,),
//           Expanded(child:
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(padding:
//               EdgeInsets.only(right:20),
//               child: Text(
//                 favoriteItem['name'],
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 17,
//
//                 ),
//               ),
//
//
//
//               ),
//
//               Text("${favoriteItem['category']} Fashion"),
//
// Text("\$${favoriteItem['price']}.00",
// style: TextStyle(
//   fontWeight: FontWeight.w600,
//   color: Colors.pink,
//
// ),)
//             ],
//
//           ))
//
//         ],),
//
//       ),
//
//
//       ),
//       Positioned(
//           top: 50,
//           right: 35,
//           child:
//       GestureDetector(onTap: (){
//         provider.toggleFavorite(favoriteDocs[index]); // instead of f
//       },
//       child: Icon(
//         Icons.delete,
//         color: Colors.red,
//         size:25
//       ),
//
//       ),)
//
//     ],
//   ),
// );
//
//
//
//           }
//
//
//         );
//
//
//
//   });
//
//      })
//
//
//
// );
//
//   }
// }
//




// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutterecommerceapp/Feature/CartProvider/favorite_provider.dart';
//
// class FavoriteScreen extends ConsumerWidget {
//   const FavoriteScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final provider = ref.watch(favoriteProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Favorites"),
//       ),
//       body: provider.favorites.isEmpty
//           ? const Center(child: Text("No favorites yet"))
//           : ListView.builder(
//         itemCount: provider.favorites.length,
//         itemBuilder: (context, index) {
//           final productId = provider.favorites[index];
//
//           return FutureBuilder<Map<String, dynamic>?>(
//             future: _getFavoriteProduct(provider, productId),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return const SizedBox.shrink();
//               }
//
//               final productData = snapshot.data!;
//               return Card(
//                 margin: const EdgeInsets.symmetric(
//                     horizontal: 12, vertical: 6),
//                 child: ListTile(
//                   leading: productData['image'] != null
//                       ? Image.network(productData['image'],
//                       width: 50, fit: BoxFit.cover)
//                       : const Icon(Icons.image, size: 50),
//                   title: Text(productData['name'] ?? "No name"),
//                   subtitle: Text("\$${productData['price']}"),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.favorite, color: Colors.red),
//                     onPressed: () {
//                       /// ✅ Call toggleFavoriteFromMap instead of toggleFavorite
//                       provider.toggleFavoriteFromMap(
//                         productId,
//                         productData,
//                       );
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   /// Helper function to fetch product details from Firestore
//   Future<Map<String, dynamic>?> _getFavoriteProduct(
//       FavoriteProvider provider, String productId) async {
//     final doc = await provider.firestore
//         .collection("userFavorite")
//         .doc(productId)
//         .get();
//
//     return doc.data();
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterecommerceapp/Feature/CartProvider/favorite_provider.dart';


class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(favoriteProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Favorites")),
      body: provider.favorites.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : ListView.builder(
        itemCount: provider.favorites.length,
        itemBuilder: (context, index) {
          final productId = provider.favorites[index];

          return FutureBuilder<Map<String, dynamic>?>(
            future: _getFavoriteProduct(provider, productId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox.shrink();

              final productData = snapshot.data!;
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: productData['image'] != null
                      ? Image.network(productData['image'], width: 50, fit: BoxFit.cover)
                      : const Icon(Icons.image, size: 50),
                  title: Text(productData['name'] ?? "No name"),
                  subtitle: Text("\$${productData['price']}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      /// Toggle favorite to remove from Firebase
                      provider.toggleFavoriteFromMap(productId, productData);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>?> _getFavoriteProduct(FavoriteProvider provider, String productId) async {
    final doc = await provider.firestore.collection("userFavorite").doc(productId).get();
    return doc.data();
  }
}
