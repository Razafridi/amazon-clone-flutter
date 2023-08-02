class Product {
  final id;
  final String name;
  final String description;
  final price;
  final quantity;
  final String imageUrl;
  final String category;
  final String userId;
  final rating;

  Product(this.id, this.name, this.description, this.price, this.quantity,
      this.imageUrl, this.category, this.userId, this.rating);

  static Product toProduct(Map<String, dynamic> map) {
    print(map);
    return Product(
        map['_id'],
        map['name'],
        map['description'],
        map['price'],
        map['quantity'],
        map['image'],
        map['category'],
        map['userId'],
        map['rating']);
  }
}
