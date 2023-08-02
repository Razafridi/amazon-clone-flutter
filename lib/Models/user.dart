class User {
  final String name;
  final String email;
  String passsword;
  String type;
  String token;
  List<dynamic> cart;

  User(
    this.name,
    this.email,
    this.passsword,
    this.type,
    this.token,
    this.cart,
  );

  static User toUser(String name, String email, String passsword, String token,
      List<dynamic> cart) {
    return User(name, email, passsword, 'user', token, cart);
  }
}
