import 'package:amazon_app/Constants/global_variable.dart';
import 'package:amazon_app/Constants/styling.dart';
import 'package:amazon_app/Features/Common/loader.dart';
import 'package:amazon_app/Features/Home/Screen/product_detail_screen.dart';
import 'package:amazon_app/Features/Home/Services/home_services.dart';
import 'package:amazon_app/Features/Home/Widgets/app_bar.dart';
import 'package:amazon_app/Features/Home/Widgets/category_list_item.dart';
import 'package:amazon_app/Features/Home/Widgets/drawer.dart';
import 'package:amazon_app/Features/Home/Widgets/search_bar.dart';
import 'package:amazon_app/Features/Home/Widgets/stars.dart';
import 'package:amazon_app/Models/product.dart';
import 'package:amazon_app/Utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  CategoryScreen(this.category);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
        await HomeServices().getAllProductsByCategory(token!, widget.category);
    productList = Utils.toListofProduct(products['products']);
    print(products);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: Colors.grey.shade300,
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
            child: productList == null
                ? Loader()
                : (productList!.length == 0
                    ? Center(
                        child: Text(
                          "No Product Found for the ${widget.category} Category",
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
                                image: productList![index].imageUrl,
                                name: productList![index].description,
                                price: productList![index].price.toString()),
                          );
                        })),
          ),
        ],
      )),
    );
  }
}
