import 'package:amazon_app/Constants/styling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderInfo extends StatelessWidget {
  final String title;
  final String value;
  const OrderInfo(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: getTexStyle(color: Colors.black87, size: 15),
        ),
        Text(
          value,
          style: getTexStyle(
              color: Colors.black, weight: FontWeight.w500, size: 16),
        ),
      ],
    );
  }
}
