class Cart {
  final id;
  final String name;
  final String description;
  final price;
  final quantity;
  final String imageUrl;
  final String category;
  final selectedItems;

  Cart(this.id, this.name, this.description, this.price, this.quantity,
      this.imageUrl, this.category, this.selectedItems);

  static Cart toCart(Map<String, dynamic> map) {
    return Cart(map['productId'], map['name'], map['description'], map['price'],
        map['quantity'], map['image'], map['category'], map['selectedItem']);
  }
}
