import 'package:amazon_app/Constants/styling.dart';
import 'package:amazon_app/Features/Auth/Widgets/custom_button.dart';
import 'package:amazon_app/Features/Common/simple_app_bar.dart';
import 'package:amazon_app/Features/Order/Services/order_services.dart';
import 'package:amazon_app/Models/cart.dart';
import 'package:amazon_app/Models/user.dart';
import 'package:amazon_app/Provider/user_provider.dart';
import 'package:amazon_app/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatelessWidget {
  final double totalAmount;
  final List<Cart> carts;

  CheckOutScreen(this.carts, this.totalAmount);

  final addressController = TextEditingController();
  final _formState = GlobalKey<FormState>();

  void _fromSubmit(BuildContext context, String token) async {
    if (_formState.currentState!.validate()) {
      var err = await OrderServices()
          .placeOrder(token, totalAmount, addressController.text, carts);
      if (err == 'success') {
        Utils.showToast(context, "Order Placed");
        Provider.of<UserProvider>(context, listen: false).clearCart();
        Navigator.of(context).pop();
      } else {
        Utils.showToast(context, err);
      }
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
          //Form
          Container(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              Form(
                key: _formState,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Address is not enter";
                    }

                    return null;
                  },
                  controller: addressController,
                  decoration: InputDecoration(
                      labelStyle: getTexStyle(),
                      focusColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: "Enter Complete Address",
                      hintStyle: getTexStyle(size: 16),
                      prefixIcon: Icon(
                        Icons.map_outlined,
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  title: "Add Order",
                  handler: () {
                    _fromSubmit(context, user.token);
                  })
            ]),
          )
        ],
      )),
    );
  }
}
