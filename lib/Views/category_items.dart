import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterecommerceapp/Models/category_model.dart';
import 'package:flutterecommerceapp/Providers/category_providers.dart';
import 'package:flutterecommerceapp/Views/items_detail_screen.dart';
import 'package:iconsax/iconsax.dart';

import '../Models/category_model.dart';
import '../Models/model.dart';
import '../Models/sub_category.dart';
import 'Colors.dart';

class CategoryItems extends ConsumerStatefulWidget {
  // final AppModel eCommerceApp;
  final String categoryy;
  // final List<AppModel> categoryItems;

  const CategoryItems({super.key, required this.categoryy});

  @override
  ConsumerState<CategoryItems> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryItems> {
  int currentIndex = 0;
  int selectedColorIndex = 1;
  int selectedSizeIndex = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productprovider = ref.watch(productsprovider(widget.categoryy));

    return productprovider.when(
      data: (categoryproduct) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios_new),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: Padding(
                            padding: const EdgeInsets.all(
                              2.0,
                            ), // padding around the Text
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ), // inner padding inside the container
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200, // background color
                                borderRadius: BorderRadius.circular(
                                  8,
                                ), // rounded corners
                              ),
                              child: Text(
                                capitalizeEachWord(widget.categoryy)+" "+
                                "Category",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                SizedBox(height: 20),

                SizedBox(height: 20),
                Expanded(
                  child: categoryproduct.isEmpty
                      ? Center(
                          child: Text(
                            "No items available in this category.",
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        )
                      : GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          itemCount: categoryproduct.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.6,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                              ),
                          itemBuilder: (context, index) {
                            final item = categoryproduct[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ItemsDetailScreen(title: item.title),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Hero(
                                    tag: item.images,

                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: fbackgroundColor2,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            item.images.isNotEmpty
                                                ? item.images[0]
                                                : 'https://via.placeholder.com/150',
                                          ),
                                          //   i have use widget . because  widget. inside a State (or ConsumerState) because the values are defined in the widget class (CuratedItems), not in the state class (_CuratedScreenState).
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      height: size.height * 0.25,
                                      width: size.width * 0.5,
                                      child: const Padding(
                                        padding: EdgeInsets.all(12),


                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "H&M",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black26,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 17,
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    width: size.width * 0.5,
                                    child: Text(
                                      item.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "\$ ${item.price.toString()}.00",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.black,
                                          height: 1.5,
                                        ),
                                      ),

                                      SizedBox(width: 5),
                                      if (item.price > 100)
                                        Text(
                                          "\$ ${item.price + 255}.00",

                                          style: const TextStyle(
                                            color: Colors.black26,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: Colors.black26,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
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

// =============function to capitalize each words =================
String capitalizeEachWord(String text) {
  if (text.isEmpty) return text;
  return text.split(" ").map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join("");
}
