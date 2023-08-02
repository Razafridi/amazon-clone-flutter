class CartItem {
  final String name;
  final String description;
  final price;
  final qunatity;
  final String image;

  CartItem(this.name, this.description, this.price, this.qunatity, this.image);

  static CartItem toCartItem(Map<String, dynamic> map) {
    return CartItem(
      map['name'],
      map['description'],
      map['price'],
      map['quantity'],
      map['image'],
    );
  }
}

class Order {
  final String orderId;
  final String address;
  final String status;
  final totalAmount;
  final List<CartItem> cartItems;

  Order(this.orderId, this.address, this.status, this.totalAmount,
      this.cartItems);
}
