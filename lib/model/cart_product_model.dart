class CartProductModel {
  String? productId, name, image, price;
  int? quantity;

  CartProductModel(
      {this.name,
      this.productId,
      this.image,
      this.quantity,
      this.price});

  CartProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map.isEmpty) {
      return;
    }

    name = map['name'];
    productId = map['productId'];
    image = map['image'];
    quantity = map['quantity'];
    price = map['price'];
  }

  toJson() {
    return {
      'name': name,
      'productId': productId,
      'image': image,
      'quantity': quantity,
      'price': price,
    };
  }
}
