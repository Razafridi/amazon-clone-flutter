import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalVariable {
  static const uri = 'http://amazon-clone-of-raz.eu-4.evennode.com';

  static const Color appbarColor = Color(0XFF07080A);
  static const Color searchBarColor = Color.fromARGB(159, 55, 56, 55);
  static const Color categoryColor = Color(0XDD07080A);

  static Color iconColor = Colors.orange.shade500;

  static const List<String> categoryList = [
    'Electronic',
    'Sport',
    'Essentials',
    'Costmetics',
    'Games',
    'Children'
  ];
  static const List<IconData> categoryIconList = [
    Icons.electric_bolt_outlined,
    Icons.sports_basketball_outlined,
    Icons.card_giftcard_outlined,
    Icons.brush_outlined,
    Icons.sports_esports_outlined,
    Icons.child_friendly_outlined
  ];

  ///Product info
  static const List<String> productList = [
    'Camera',
    'Classes',
    'Shoes',
    'Lipstick',
  ];
  static const List<String> productListImages = [
    './Assets/product1.jpg',
    './Assets/product2.jpg',
    './Assets/product3.jpg',
    './Assets/product4.jpg',
  ];
}
