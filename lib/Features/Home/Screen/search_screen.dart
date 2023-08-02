import 'package:amazon_app/Constants/styling.dart';
import 'package:amazon_app/Features/Common/app_bar_back.dart';
import 'package:amazon_app/Features/Common/loader.dart';
import 'package:amazon_app/Features/Home/Screen/product_detail_screen.dart';
import 'package:amazon_app/Features/Home/Services/home_services.dart';
import 'package:amazon_app/Features/Home/Widgets/category_list_item.dart';
import 'package:amazon_app/Models/product.dart';
import 'package:amazon_app/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  final String searchText;
  const SearchScreen(this.searchText);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? productList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  void getProducts() async {
    var pref = await SharedPreferences.getInstance();
    var token = await pref.getString('token');
    var products =
        await HomeServices().getAllProductsBySearch(token!, widget.searchText);
    productList = Utils.toListofProduct(products['products']);
    print(products);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //App bar
          NormalAppBar(),
          //
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Search for Keyword: ${widget.searchText}",
              style: getTexStyle(weight: FontWeight.bold, size: 16),
            ),
          ),
          //Showing Result

          Expanded(
              child: productList == null
                  ? Loader()
                  : (productList!.length == 0
                      ? Center(
                          child: Text(
                            "No Result Found",
                            style: getTexStyle(),
                          ),
                        )
                      : ListView.builder(
                          itemCount: productList!.length,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (ctx) => ProductDetailScreen(
                                          productList![index])),
                                );
                              },
                              child: CategoryListItem(
                                  ratings: productList![index].rating,
                                  name: productList![index].description,
                                  image: productList![index].imageUrl,
                                  price: productList![index].price.toString()),
                            );
                          })))
        ],
      )),
    );
  }
}
