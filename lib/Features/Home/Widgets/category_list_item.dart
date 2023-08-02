import 'package:amazon_app/Constants/styling.dart';
import 'package:amazon_app/Features/Home/Widgets/stars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryListItem extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final List<dynamic> ratings;

  const CategoryListItem({
    required this.name,
    required this.image,
    required this.price,
    required this.ratings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 10,
      ),
      child: Row(
        children: [
          Image.network(
            image,
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4,
            fit: BoxFit.cover,
          ),
          //Details
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: getTexStyle(
                    weight: FontWeight.w500,
                    size: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Stars(ratings),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '\$${price}',
                  style: getTexStyle(
                    size: 20,
                    weight: FontWeight.w600,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
