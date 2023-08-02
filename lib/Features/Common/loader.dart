import 'package:amazon_app/Constants/global_variable.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: GlobalVariable.appbarColor),
    );
  }
}
