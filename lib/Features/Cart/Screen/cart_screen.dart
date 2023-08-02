import 'package:amazon_app/Constants/styling.dart';
import 'package:amazon_app/Features/Cart/Services/cart_services.dart';
import 'package:amazon_app/Features/Cart/Widgets/cart_item.dart';
import 'package:amazon_app/Features/Common/loader.dart';
import 'package:amazon_app/Features/Common/simple_app_bar.dart';
import 'package:amazon_app/Features/Order/Screen/checkout_screen.dart';
import 'package:amazon_app/Models/cart.dart';
import 'package:amazon_app/Models/user.dart';
import 'package:amazon_app/Provider/user_provider.dart';
import 'package:amazon_app/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Cart> cartList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCarts();
  }

  void getCarts() async {
    try {
      User user = Provider.of<UserProvider>(context).getUser();
      var data = user.cart;
      cartList = Utils.toListofCart(data);

      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //App Bar
            SimpleBarBar(),

            //Calculate price
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total : ${Provider.of<UserProvider>(context).getTotalPrice()}",
                      style: getTexStyle(weight: FontWeight.bold, size: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          if (user.cart.isEmpty) {
                            Utils.showToast(context, "Not Product is selected");
                            return;
                          }
                          List<Cart> list = [];
                          user.cart.forEach((element) {
                            list.add(Cart.toCart(element));
                          });
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => CheckOutScreen(
                                  list,
                                  Provider.of<UserProvider>(context)
                                      .getTotalPrice()),
                            ),
                          );
                        },
                        child: Text("Place Order"))
                  ],
                )),
            //Cart Items

            Expanded(
              child: ListView.builder(
                  itemCount: user.cart.length,
                  itemBuilder: (ctx, index) {
                    Cart cart = Cart.toCart(user.cart[index]);
                    print("Hello from Cart ${index} of name ${cart.name}");
                    return CartItem(cart);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
