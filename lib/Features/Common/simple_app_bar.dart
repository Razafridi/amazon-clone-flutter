import 'package:amazon_app/Constants/global_variable.dart';
import 'package:flutter/material.dart';

class SimpleBarBar extends StatelessWidget {
  const SimpleBarBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalVariable.appbarColor,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          Image.asset(
            './Assets/logo.png',
            height: 30,
          ),
          Row(
            children: [
              Icon(
                Icons.notifications_none_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
