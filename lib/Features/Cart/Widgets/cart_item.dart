import 'package:amazon_app/Constants/styling.dart';
import 'package:amazon_app/Features/Home/Widgets/stars.dart';
import 'package:amazon_app/Models/cart.dart';
import 'package:amazon_app/Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final Cart cartItem;
  CartItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    int quantity =
        Provider.of<UserProvider>(context).getQuantityById(cartItem.id);
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(blurRadius: 1, spreadRadius: 1, blurStyle: BlurStyle.outer)
      ]),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          //Line 1
          Row(children: [
            //Pic
            Image.network(
              cartItem.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            //Details
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.name,
                    style: getTexStyle(weight: FontWeight.bold, size: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Rs. ${cartItem.price}",
                    style: getTexStyle(weight: FontWeight.bold, size: 14),
                  ),
                ],
              ),
            )
          ]),

          //Line 2
          SizedBox(
            height: 5,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Provider.of<UserProvider>(context, listen: false)
                          .subttractFromCart(cartItem.id);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Icon(Icons.remove),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: Colors.grey.shade300)),
                    child: Text(
                      '${quantity}',
                      style: getTexStyle(weight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //Add to cart
                      Provider.of<UserProvider>(context, listen: false)
                          .addOneToCart(cartItem.id);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Icon(Icons.add),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'x ${cartItem.price * cartItem.selectedItems}',
                    style: getTexStyle(
                      size: 20,
                    ),
                  )
                ],
              ),
              IconButton(
                  onPressed: () {
                    //Deleete to cart
                    Provider.of<UserProvider>(context, listen: false)
                        .deleteFromCart(cartItem.id);
                  },
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
