import 'dart:async';

import 'package:amazon_app/Constants/global_variable.dart';
import 'package:amazon_app/Features/Auth/Screens/auth_screen.dart';
import 'package:amazon_app/Features/Common/loader.dart';
import 'package:amazon_app/Features/Home/Screen/category_screen.dart';
import 'package:amazon_app/Features/Home/Screen/product_detail_screen.dart';
import 'package:amazon_app/Features/Home/Services/home_services.dart';
import 'package:amazon_app/Features/Home/Widgets/app_bar.dart';
import 'package:amazon_app/Features/Home/Widgets/category.dart';
import 'package:amazon_app/Features/Home/Widgets/drawer.dart';
import 'package:amazon_app/Features/Home/Widgets/product.dart';
import 'package:amazon_app/Features/Home/Widgets/search_bar.dart';
import 'package:amazon_app/Models/product.dart';
import 'package:amazon_app/Utils/utils.dart';
import '../../../Models/user.dart';
import 'package:amazon_app/Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? token;
  List<Product>? productList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    getProducts();
  }

  void getToken() async {
    var pref = await SharedPreferences.getInstance();
    token = await pref.getString('token');

    var res = await HomeServices().verifyUser(token!);
    if (res == 'error') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => AuthScreen()),
      );
    }
    print(res);
    var user = res['user'];
    Timer(Duration(milliseconds: 500), () {
      Provider.of<UserProvider>(context, listen: false).setUser(
          user['name'], user['email'], user['password'], token!, user['cart']);
    });
  }

  void getProducts() async {
    var pref = await SharedPreferences.getInstance();
    token = await pref.getString('token');
    var products = await HomeServices().getAllProducts(token!);
    productList = Utils.toListofProduct(products['products']);
    print(products);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser();

    return Scaffold(
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Column(children: [
            //App Bar
            CustomAppBar(),
            //Search
            Container(
              color: GlobalVariable.appbarColor,
              child: CustomSearchBar(),
            ),

            //Category
            Container(
              height: 80,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: GlobalVariable.categoryList.length,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (ctx) => CategoryScreen(
                                  GlobalVariable.categoryList[index])),
                        );
                      },
                      child: Container(
                        color: GlobalVariable.categoryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Category(
                            title: GlobalVariable.categoryList[index],
                            icon: GlobalVariable.categoryIconList[index],
                          ),
                        ),
                      ),
                    );
                  }),
            ),

            //Gridview of products

            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: productList == null
                  ? Loader()
                  : GridView.builder(
                      itemCount: productList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (ctx, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      ProductDetailScreen(productList![index])),
                            );
                          },
                          child: ProductDetail(
                            productList![index],
                          ),
                        );
                      }),
            )),
          ]),
        ));
  }
}
