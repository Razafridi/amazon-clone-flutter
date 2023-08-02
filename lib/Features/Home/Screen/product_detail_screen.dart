import 'dart:io';

import 'package:amazon_app/Constants/global_variable.dart';
import 'package:amazon_app/Constants/styling.dart';
import 'package:amazon_app/Features/Home/Services/home_services.dart';
import 'package:amazon_app/Features/Home/Widgets/app_bar.dart';
import 'package:amazon_app/Features/Home/Widgets/search_bar.dart';
import 'package:amazon_app/Features/Home/Widgets/stars.dart';
import 'package:amazon_app/Models/product.dart';
import 'package:amazon_app/Models/user.dart';
import 'package:amazon_app/Provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product productDetails;
  ProductDetailScreen(this.productDetails);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String rateValue = 'Not rate yet';
  @override
  Widget build(BuildContext context) {
    User userDetails = Provider.of<UserProvider>(context).getUser();
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //App Bar
          CustomAppBar(),
          //Search
          Container(
            color: GlobalVariable.appbarColor,
            child: CustomSearchBar(),
          ),
          Expanded(
              child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //Product Details
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.productDetails.name,
                      style: getTexStyle(weight: FontWeight.bold),
                    ),
                    Stars(widget.productDetails.rating),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              //Iamge

              Image.network(
                widget.productDetails.imageUrl,
                width: double.infinity,
              ),
              //Price and Quantity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Price",
                      style: getTexStyle(size: 18, weight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "\Rs. ${widget.productDetails.price}",
                          style: getTexStyle(size: 16, weight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: widget.productDetails.quantity > 0
                                  ? Colors.teal
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            widget.productDetails.quantity > 0
                                ? 'In Stock'
                                : 'Out of Stock',
                            style: getTexStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),

              //Details
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Details",
                  style: getTexStyle(size: 18, weight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.productDetails.description,
                  style: getTexStyle(size: 16, weight: FontWeight.normal),
                ),
              ),
              Divider(
                color: Colors.black54,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      "Rate Us",
                      style: getTexStyle(
                        weight: FontWeight.w600,
                        size: 16,
                      ),
                    ),
                    Text(
                      '  (${rateValue})',
                      style: getTexStyle(weight: FontWeight.w500, size: 14),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) async {
                      rateValue = rating.toString();
                      await HomeServices().rateTheProduct(
                          userDetails.token, widget.productDetails.id, rating);
                      setState(() {});
                    },
                  ),
                  TextButton(onPressed: () {}, child: Text("Submit Review"))
                ],
              ),
            ]),
          ))
        ],
      )),
    );
  }
}
