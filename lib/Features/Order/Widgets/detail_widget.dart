import 'package:amazon_app/Constants/global_variable.dart';
import 'package:amazon_app/Constants/styling.dart';
import 'package:flutter/cupertino.dart';

class DetailWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const DetailWidget(
    this.icon,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(
            icon,
            color: GlobalVariable.iconColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: getTexStyle(),
          )
        ],
      ),
    );
  }
}
