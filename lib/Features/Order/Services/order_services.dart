import 'dart:convert';

import 'package:amazon_app/Constants/error_handling.dart';
import 'package:amazon_app/Constants/global_variable.dart';
import 'package:amazon_app/Models/cart.dart';
import 'package:http/http.dart' as http;

class OrderServices {
  Future<String> placeOrder(
      String token, double total, String address, List<Cart> cart) async {
    try {
      //Convert into list
      List<Map<String, dynamic>> listCart = [];
      cart.forEach((element) {
        listCart.add({
          "name": element.name,
          "description": element.description,
          "productId": element.id,
          "quantity": element.selectedItems,
          "price": element.price,
          "image": element.imageUrl,
        });
      });
      //Sending http req
      http.Response res =
          await http.post(Uri.parse('${GlobalVariable.uri}/order/place-order'),
              headers: {
                'Content-Type': 'application/json',
                'token': token,
              },
              body: jsonEncode({
                "totalAmount": total,
                "address": address,
                "orderItems": listCart,
              }));

      if (res.statusCode != 200) {
        return ErrorHandling.NetworkError(res);
      }

      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> getUserOrders(String token) async {
    try {
      //Convert into list

      //Sending http req
      http.Response res = await http.get(
        Uri.parse('${GlobalVariable.uri}/order/get-user-orders'),
        headers: {
          'Content-Type': 'application/json',
          'token': token,
        },
      );

      if (res.statusCode != 200) {
        return ErrorHandling.NetworkError(res);
      }

      return jsonDecode(res.body);
    } catch (e) {
      return e.toString();
    }
  }
}
