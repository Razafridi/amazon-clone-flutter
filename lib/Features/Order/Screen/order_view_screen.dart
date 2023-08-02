import 'package:amazon_app/Constants/styling.dart';
import 'package:amazon_app/Features/Common/simple_app_bar.dart';
import 'package:amazon_app/Features/Order/Widgets/detail_widget.dart';
import 'package:amazon_app/Features/Order/Widgets/order_info.dart';
import 'package:amazon_app/Models/user.dart';
import 'package:amazon_app/Provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../../../Models/order.dart';
import 'package:flutter/material.dart';

class OrderViewScreen extends StatelessWidget {
  final Order orderDetails;
  OrderViewScreen(this.orderDetails);

  @override
  Widget build(BuildContext context) {
    User userDetails = Provider.of<UserProvider>(context).getUser();
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //App Bar
          SimpleBarBar(),
          //Adress Details

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivory Address",
                  style: getTexStyle(weight: FontWeight.w500, size: 16),
                ),
                SizedBox(
                  height: 5,
                ),

                Text(
                  "Home",
                  style: getTexStyle(
                      size: 14, color: Colors.black54, weight: FontWeight.w600),
                ),

                DetailWidget(
                    Icons.maps_home_work_outlined, orderDetails.address),
                DetailWidget(Icons.person_4_outlined, userDetails.name),
                DetailWidget(Icons.email_outlined, userDetails.email),
                Divider(
                  color: Colors.black54,
                ),

                //Bill info

                Text(
                  "Bill Address",
                  style: getTexStyle(weight: FontWeight.w500, size: 16),
                ),
                SizedBox(
                  height: 5,
                ),

                OrderInfo("Items", orderDetails.cartItems.length.toString()),
                SizedBox(
                  height: 5,
                ),

                OrderInfo("Status", orderDetails.status),
                SizedBox(
                  height: 5,
                ),
                OrderInfo("Total Price", orderDetails.totalAmount.toString()),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Colors.black54,
                ),
                //All Items
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Order Items",
              style: getTexStyle(
                weight: FontWeight.w500,
                size: 16,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: orderDetails.cartItems.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(orderDetails.cartItems[index].image),
                    ),
                    title: Text(
                      orderDetails.cartItems[index].name,
                      style: getTexStyle(size: 16, weight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      "Price Rs. ${orderDetails.cartItems[index].price.toString()}",
                      style: getTexStyle(),
                    ),
                    trailing: Text(
                      'Items: ${orderDetails.cartItems[index].qunatity.toString()}',
                      style: getTexStyle(weight: FontWeight.bold),
                    ),
                  );
                }),
          )
        ],
      )),
    );
  }
}
