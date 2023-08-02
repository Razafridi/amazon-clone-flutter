import 'package:amazon_app/Constants/styling.dart';
import 'package:amazon_app/Features/Common/loader.dart';
import 'package:amazon_app/Features/Common/simple_app_bar.dart';
import 'package:amazon_app/Features/Order/Screen/order_view_screen.dart';
import 'package:amazon_app/Features/Order/Services/order_services.dart';
// import 'package:amazon_app/Features/Order/Widgets/order.dart' ;
import 'package:amazon_app/Models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? allOredrs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllOrders();
  }

  void getAllOrders() async {
    var pref = await SharedPreferences.getInstance();

    String? token = pref.getString('token');

    var data = await OrderServices().getUserOrders(token!);

    List<Order> ord = [];

    data.forEach((element) {
      List<CartItem> cartList = [];
      element['orderItems'].forEach((cartItem) {
        cartList.add(CartItem.toCartItem(cartItem));
      });

      ord.add(Order(element['_id'], element['address'], element['status'],
          element['totalAmount'], cartList));
    });
    allOredrs = ord;
    setState(() {});
    print("All Orders");
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          //App Bar
          SimpleBarBar(),
          //All Orders

          Expanded(
              child: allOredrs == null
                  ? Loader()
                  : ListView.builder(
                      itemCount: allOredrs!.length,
                      itemBuilder: (ctx, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) =>
                                    OrderViewScreen(allOredrs![index]),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              leading: Text(allOredrs![index].status,
                                  style: getTexStyle(
                                      color:
                                          allOredrs![index].status == 'Pending'
                                              ? Colors.red
                                              : Colors.green,
                                      weight: FontWeight.bold)),
                              title: Text(
                                "Total Price ${allOredrs![index].totalAmount}",
                                style: getTexStyle(
                                    size: 14, weight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  "Order Id : ${allOredrs![index].orderId}"),
                              trailing: Icon(Icons.arrow_forward_ios_rounded),
                            ),
                          ),
                        );
                      }))
        ],
      )),
    );
  }
}
