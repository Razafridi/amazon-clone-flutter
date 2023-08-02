import 'dart:convert';

import 'package:amazon_app/Constants/error_handling.dart';
import 'package:amazon_app/Constants/global_variable.dart';
import 'package:amazon_app/Models/keypair.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<dynamic> verifyUser(String token) async {
    http.Response res = await http.post(
      Uri.parse('${GlobalVariable.uri}/api/get-user'),
      headers: {
        'Content-Type': 'application/json',
        'token': token,
      },
    );
    //
    print(jsonDecode(res.body));
    if (res.statusCode != 200) {
      String err = ErrorHandling.NetworkError(res);
      return 'error';
    }
    return jsonDecode(res.body);
  }

  Future<dynamic> getAllProducts(String token) async {
    try {
      http.Response res = await http.get(
        Uri.parse('${GlobalVariable.uri}/seller/get-products'),
        headers: {
          'Content-Type': 'application/json',
          'token': token,
        },
      );
      //
      print(jsonDecode(res.body));
      if (res.statusCode != 200) {
        String err = ErrorHandling.NetworkError(res);
        return 'error';
      }
      return jsonDecode(res.body);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  //Grap Products by category

  Future<dynamic> getAllProductsByCategory(
      String token, String category) async {
    try {
      http.Response res = await http.get(
        Uri.parse(
            '${GlobalVariable.uri}/seller/get-product-by-category/$category'),
        headers: {
          'Content-Type': 'application/json',
          'token': token,
        },
      );
      //
      print(jsonDecode(res.body));
      if (res.statusCode != 200) {
        String err = ErrorHandling.NetworkError(res);
        return 'error';
      }
      return jsonDecode(res.body);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  //Grap Products by Search

  Future<dynamic> getAllProductsBySearch(String token, String search) async {
    try {
      http.Response res = await http.get(
        Uri.parse('${GlobalVariable.uri}/seller/search-product?search=$search'),
        headers: {
          'Content-Type': 'application/json',
          'token': token,
        },
      );
      //
      print(jsonDecode(res.body));
      if (res.statusCode != 200) {
        String err = ErrorHandling.NetworkError(res);
        return 'error';
      }
      return jsonDecode(res.body);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  //Rating Product

  Future<dynamic> rateTheProduct(
      String token, String productId, double rating) async {
    try {
      http.Response res = await http.post(
          Uri.parse('${GlobalVariable.uri}/rating/rate-product'),
          headers: {
            'Content-Type': 'application/json',
            'token': token,
          },
          body: jsonEncode({
            'productId': productId,
            "rating": rating,
          }));
      //
      print(jsonDecode(res.body));
      if (res.statusCode != 200) {
        String err = ErrorHandling.NetworkError(res);
        return 'error';
      }
      return jsonDecode(res.body);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
