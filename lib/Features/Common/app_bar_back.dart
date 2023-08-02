import 'package:amazon_app/Constants/global_variable.dart';
import 'package:amazon_app/Models/user.dart';
import 'package:amazon_app/Provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class NormalAppBar extends StatelessWidget {
  const NormalAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser();

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
              badges.Badge(
                badgeStyle:
                    badges.BadgeStyle(badgeColor: GlobalVariable.iconColor),
                badgeContent: Text(user.cart.length.toString()),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
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
