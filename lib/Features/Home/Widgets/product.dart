import 'package:amazon_app/Constants/styling.dart';
import 'package:amazon_app/Features/Cart/Services/cart_services.dart';
import 'package:amazon_app/Models/product.dart';
import 'package:amazon_app/Models/user.dart';
import 'package:amazon_app/Provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail(this.product);

  void _addToCart(BuildContext context) async {
    Provider.of<UserProvider>(context, listen: false)
        .addtoCart(product.id, product);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              product.imageUrl,
              height: MediaQuery.of(context).size.width / 2,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                style: getTexStyle(
                    size: 18, weight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          //top
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                //add to Cart
              },
              child: InkWell(
                onTap: () {
                  _addToCart(context);
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
