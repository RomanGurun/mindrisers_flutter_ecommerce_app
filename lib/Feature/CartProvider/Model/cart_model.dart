class CartModel{
  final String productId; //use the product id form a firestore
  final Map<String,dynamic> productData;   ///store product Details asmap
  int quantity;
  // final String selectedColor; /// new feild for selected color
  // final String selectedSize;/// new feild for selected size

  CartModel({
    required this.productId,
    required this.productData,
    required this.quantity,
    // required this.selectedColor, //update constructor
    // required this.selectedSize, ///update constructor

});

  

}
