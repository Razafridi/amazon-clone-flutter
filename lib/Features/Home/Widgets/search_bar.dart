import 'package:amazon_app/Constants/global_variable.dart';
import 'package:amazon_app/Features/Home/Screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: GlobalVariable.searchBarColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        style: GoogleFonts.raleway(color: Colors.white),
        onSubmitted: (value) {
          print("FormSbmitted " + value);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => SearchScreen(value)),
          );
        },
        decoration: InputDecoration(
            hintText: "Search Product...",
            hintStyle: GoogleFonts.raleway(color: Colors.grey),
            border: InputBorder.none,
            // contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              CupertinoIcons.search,
              color: Colors.white,
            ),
            suffixIcon: Icon(
              CupertinoIcons.qrcode_viewfinder,
              color: Colors.white,
            )),
      ),
    );
  }
}
