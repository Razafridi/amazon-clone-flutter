import 'dart:convert';

import 'package:amazon_app/Constants/error_handling.dart';
import 'package:amazon_app/Constants/global_variable.dart';
import 'package:http/http.dart' as http;

class CartServices {
  Future<void> addToCart(String productId, String token) async {
    try {
      http.Response response =
          await http.post(Uri.parse('${GlobalVariable.uri}/cart/add-to-cart'),
              headers: {
                'Content-Type': 'application/json',
                'token': token,
              },
              body: jsonEncode({
                'productId': productId,
              }));

      if (response.statusCode != 200) {
        var message = ErrorHandling.NetworkError(response);
        print(message);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<dynamic> getAllCarts(String token) async {
  //   try {
  //     http.Response res = await http.get(
  //       Uri.parse('${GlobalVariable.uri}/cart/get-carts'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'token': token,
  //       },
  //     );
  //     //
  //     print(jsonDecode(res.body));
  //     if (res.statusCode != 200) {
  //       String err = ErrorHandling.NetworkError(res);
  //       return 'error';
  //     }
  //     return jsonDecode(res.body);
  //   } catch (e) {
  //     print(e.toString());
  //     return e.toString();
  //   }
  // }

  //Subtract from cart

  Future<void> subtractFromCart(String productId, String token) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${GlobalVariable.uri}/cart/subtract-from-cart'),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          },
          body: jsonEncode({
            'productId': productId,
          }));

      if (response.statusCode != 200) {
        var message = ErrorHandling.NetworkError(response);
        print(message);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Subtract from cart

  Future<void> deleteCartItem(String productId, String token) async {
    try {
      http.Response response = await http.post(
          Uri.parse('${GlobalVariable.uri}/cart/delete-from-cart'),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          },
          body: jsonEncode({
            'productId': productId,
          }));

      if (response.statusCode != 200) {
        var message = ErrorHandling.NetworkError(response);
        print(message);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> clearCart(String token) async {
    http.Response cartRes = await http
        .delete(Uri.parse('${GlobalVariable.uri}/cart/clear-cart'), headers: {
      'Content-Type': 'application/json',
      'token': token,
    });
  }
}
