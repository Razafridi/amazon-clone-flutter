import 'dart:io';

import 'package:amazon_app/Models/cart.dart';
import 'package:amazon_app/Models/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  static void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static Future<dynamic> selectFile(ImageSource source) async {
    var picker = ImagePicker();
    var selectedFile = await picker.pickImage(source: source);

    if (selectedFile == null) {
      return null;
    }
    return File(selectedFile.path);
  }

  static List<Product> toListofProduct(List<dynamic> maps) {
    List<Product> list = maps.map((product) {
      return Product.toProduct(product);
    }).toList();
    return list;
  }

  static List<Cart> toListofCart(List<dynamic> maps) {
    List<Cart> list = maps.map((cart) {
      return Cart.toCart(cart);
    }).toList();
    return list;
  }

  static double getStars(List<dynamic> rating) {
    if (rating.length == 0) {
      return 0;
    }
    double tot = 0;
    rating.forEach((element) {
      tot += element['rating'];
    });
    return tot;
  }
}
