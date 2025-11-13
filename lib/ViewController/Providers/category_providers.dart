import 'package:flutterecommerceapp/Models/category_products.dart';
import 'package:flutterecommerceapp/Models/products.dart';
import 'package:flutterecommerceapp/ViewController/Repository/sell_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryproductprovider = FutureProvider<List<CategoryProduct>>((ref){
  return SellsRepository.getCategoryProduct();
});


final onlyproductprovider = FutureProvider<List<Product>>((ref){
  return SellsRepository.getProductOnly();

});


final productsprovider = FutureProvider.family<List<Product>,String>((ref,categoryname){
  return SellsRepository.getProduct(categoryname: categoryname);

});

final filterproductsprovider = FutureProvider.family<List<Product>,String>((ref,titlename){
  return SellsRepository.getSingleProduct(titlename: titlename);

});






