import 'package:amazon_app/Constants/global_variable.dart';
import 'package:amazon_app/Constants/styling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Category extends StatelessWidget {
  final String title;
  final IconData icon;
  Category({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: GlobalVariable.iconColor),
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: getTexStyle(color: Colors.white70),
        ),
      ],
    );
  }
}
