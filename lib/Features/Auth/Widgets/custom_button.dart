import 'package:amazon_app/Constants/styling.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback handler;
  const CustomButton({
    required this.title,
    required this.handler,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: handler,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: getTexStyle(size: 16, color: Colors.white),
          ),
        ));
  }
}
