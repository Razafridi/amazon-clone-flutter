import 'package:amazon_app/Constants/styling.dart';
import 'package:amazon_app/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  final List<dynamic> ratings;
  const Stars(this.ratings);

  @override
  Widget build(BuildContext context) {
    double rating = Utils.getStars(ratings);
    return Row(
      children: [
        Text(
          '($rating) ',
          style: getTexStyle(color: Colors.orange.shade400),
        ),
        Icon(
          Icons.star,
          color: rating > 0 ? Colors.orange : Colors.grey,
          size: 16,
        ),
        Icon(
          Icons.star,
          color: rating > 1 ? Colors.orange : Colors.grey,
          size: 16,
        ),
        Icon(
          Icons.star,
          color: rating > 2 ? Colors.orange : Colors.grey,
          size: 16,
        ),
        Icon(
          Icons.star,
          color: rating > 3 ? Colors.orange : Colors.grey,
          size: 16,
        ),
        Icon(
          Icons.star,
          color: rating > 4 ? Colors.orange : Colors.grey,
          size: 16,
        ),
        Text(
          "  Reviews: ${ratings.length}",
          style: getTexStyle(color: Colors.blue.shade300),
        )
      ],
    );
  }
}
