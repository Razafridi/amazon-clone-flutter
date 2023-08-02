import 'package:amazon_app/Features/Cart/Services/cart_services.dart';
import 'package:amazon_app/Models/product.dart';
import 'package:amazon_app/Models/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User user = User('', '', '', '', '', []);

  void setUser(String name, String email, String passsword, String token,
      List<dynamic> cart) {
    user = User.toUser(name, email, passsword, token, cart);
    notifyListeners();
  }

  void addOneToCart(String productId) async {
    int index =
        user.cart.indexWhere((element) => element['productId'] == productId);

    if (index >= 0) {
      print("Item Already in  provider cart");
      user.cart[index]['selectedItem'] += 1;
    }
    notifyListeners();
    await CartServices().addToCart(productId, user.token);
  }

  void addtoCart(String productId, Product product) async {
    int index =
        user.cart.indexWhere((element) => element['productId'] == productId);

    if (index >= 0) {
      print("Item Already in  provider cart");
      user.cart[index]['selectedItem'] += 1;
    } else {
      user.cart.add({
        'productId': productId,
        'selectedItem': 1,
        'name': product.name,
        'description': product.description,
        'userId': product.userId,
        'category': product.category,
        'price': product.price,
        'quantity': product.quantity,
        'rating': product.rating,
        'image': product.imageUrl,
      });
    }
    notifyListeners();

    await CartServices().addToCart(productId, user.token);
  }

  ///Subtract from cart
  void subttractFromCart(String productId) async {
    int index =
        user.cart.indexWhere((element) => element['productId'] == productId);

    if (user.cart[index]['selectedItem'] > 1) {
      print("Item Already in  provider cart");
      user.cart[index]['selectedItem'] -= 1;
    }

    notifyListeners();

    await CartServices().subtractFromCart(productId, user.token);
  }

//Delete from cart

  void deleteFromCart(String productId) async {
    int index =
        user.cart.indexWhere((element) => element['productId'] == productId);

    user.cart.removeAt(index);

    notifyListeners();

    await CartServices().deleteCartItem(productId, user.token);
  }

  User getUser() {
    return user;
  }

  int getQuantityById(String productId) {
    int index =
        user.cart.indexWhere((element) => element['productId'] == productId);
    return user.cart[index]['selectedItem'];
  }

  bool isAvailable(String productId) {
    int index =
        user.cart.indexWhere((element) => element['productId'] == productId);
    return index >= 0 ? true : false;
  }

  // List<Cart>

  double getTotalPrice() {
    double tot = 0;
    user.cart.forEach((element) {
      tot += element['selectedItem'] * element['price'];
    });
    return tot;
  }

  //Clear cart

  void clearCart() async {
    user.cart = [];
    notifyListeners();
    await CartServices().clearCart(user.token);
  }
}
