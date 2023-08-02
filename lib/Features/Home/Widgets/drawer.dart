import 'package:amazon_app/Constants/global_variable.dart';
import 'package:amazon_app/Constants/styling.dart';
import 'package:amazon_app/Features/Auth/Screens/auth_screen.dart';
import 'package:amazon_app/Features/Order/Screen/orders_screen.dart';
import 'package:amazon_app/Features/Seller%20Screens/Screens/add_product_screen.dart';
import 'package:amazon_app/Models/user.dart';
import 'package:amazon_app/Provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    User userinfo = Provider.of<UserProvider>(context).getUser();
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.all(10),
          color: GlobalVariable.appbarColor,
          width: double.infinity,
          height: 200,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: getTexStyle(color: Colors.white, size: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mr ${userinfo.name}",
                            style: getTexStyle(
                                color: Colors.white,
                                size: 18,
                                weight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.clear();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (ctx) => AuthScreen()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.login,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 10),
          child: Text(
            "Sell Product",
            style: getTexStyle(
                color: Colors.black, weight: FontWeight.bold, size: 20),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),

        //Selling Product
        Padding(
          padding: EdgeInsets.all(5),
          child: TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => AddProductScreen()),
              );
            },
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
            label: Text(
              "Add Product",
              style: getTexStyle(
                color: Colors.black,
                size: 16,
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 10),
          child: Text(
            "Orders",
            style: getTexStyle(
                color: Colors.black, weight: FontWeight.bold, size: 20),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),

        //Selling Product
        Padding(
          padding: EdgeInsets.all(5),
          child: TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => OrdersScreen()),
              );
            },
            icon: Icon(
              Icons.delivery_dining_outlined,
              color: Colors.black,
            ),
            label: Text(
              "View Orders",
              style: getTexStyle(
                color: Colors.black,
                size: 16,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
