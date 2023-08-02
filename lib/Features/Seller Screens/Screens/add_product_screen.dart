import 'dart:io';

import 'package:amazon_app/Constants/global_variable.dart';
import 'package:amazon_app/Constants/styling.dart';
import 'package:amazon_app/Features/Auth/Widgets/custom_button.dart';
import 'package:amazon_app/Features/Common/app_bar_back.dart';
import 'package:amazon_app/Features/Common/loader.dart';
import 'package:amazon_app/Features/Home/Widgets/app_bar.dart';
import 'package:amazon_app/Features/Home/Widgets/category.dart';
import 'package:amazon_app/Features/Seller%20Screens/Services/product_services.dart';
import 'package:amazon_app/Provider/user_provider.dart';
import 'package:amazon_app/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();

  final descriptionController = TextEditingController();

  final quantityController = TextEditingController();

  final priceController = TextEditingController();

  final _formState = GlobalKey<FormState>();

  final List<DropdownMenuItem> category = GlobalVariable.categoryList
      .map((e) => DropdownMenuItem(child: Text(e)))
      .toList();
  String currentCat = GlobalVariable.categoryList[0];

  File? image;
  bool isLoading = false;
  void submitForm(BuildContext context) async {
    if (image == null) {
      Utils.showToast(context, "Image is not Selected");
      return;
    }
    if (_formState.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var res = await ProductServices().addProduct(
          category: currentCat,
          userId:
              Provider.of<UserProvider>(context, listen: false).getUser().token,
          name: nameController.text,
          desctiption: descriptionController.text,
          price: priceController.text,
          quantity: quantityController.text,
          image: image!);
      setState(() {
        isLoading = false;
      });
      if (res == 'success') {
        Utils.showToast(context, "Product Added Successfully");
        nameController.clear();
        descriptionController.clear();
        priceController.clear();
        quantityController.clear();
        image = null;
      } else {
        Utils.showToast(context, "Something went wrong");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //App Bar
              NormalAppBar(),
              //
              InkWell(
                onTap: () async {
                  var selectedFile =
                      await Utils.selectFile(ImageSource.gallery);
                  if (selectedFile == null) {
                    Utils.showToast(context, "Image is not Selected");
                  } else {
                    image = selectedFile;
                    setState(() {});
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Colors.grey)),
                  child: image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            image!,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(child: Icon(Icons.add_photo_alternate_outlined)),
                ),
              ),

              //Form
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: _formState,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name is Empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelStyle: getTexStyle(),
                            focusColor: Colors.grey,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            hintText: "Enter Product Name",
                            hintStyle: getTexStyle(size: 16),
                            prefixIcon: Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.grey,
                            ),
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        //Decription
                        TextFormField(
                          controller: descriptionController,
                          validator: (value) {
                            if (value!.length < 20) {
                              return "Description must contains at least 20 characters";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelStyle: getTexStyle(),
                              focusColor: Colors.grey,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintText: "Enter Product Description",
                              hintStyle: getTexStyle(size: 16),
                              prefixIcon: Icon(
                                Icons.description_outlined,
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //Quantity
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Quantity is Empty";
                            }
                            if (int.parse(value) <= 0) {
                              return "Price must be positive number";
                            }

                            return null;
                          },
                          controller: quantityController,
                          decoration: InputDecoration(
                              labelStyle: getTexStyle(),
                              focusColor: Colors.grey,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintText: "Enter Product Quantity",
                              hintStyle: getTexStyle(size: 16),
                              prefixIcon: Icon(
                                Icons.numbers,
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //Price
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Price is not enter";
                            }
                            if (double.parse(value!) <= 0) {
                              return "Price must be greater than 0";
                            }
                            return null;
                          },
                          controller: priceController,
                          decoration: InputDecoration(
                              labelStyle: getTexStyle(),
                              focusColor: Colors.grey,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintText: "Enter Product Price",
                              hintStyle: getTexStyle(size: 16),
                              prefixIcon: Icon(
                                Icons.money_outlined,
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)),
                          child: DropdownButton(
                              style: getTexStyle(color: Colors.black),
                              value: currentCat,
                              borderRadius: BorderRadius.circular(10),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              icon: Icon(Icons.arrow_drop_down_outlined),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  currentCat = value!;
                                });
                              },
                              items: GlobalVariable.categoryList
                                  .map((e) => DropdownMenuItem(
                                        child: Text(e),
                                        value: e,
                                      ))
                                  .toList()),
                        ),

                        const SizedBox(
                          height: 5,
                        ),
                        isLoading
                            ? Loader()
                            : CustomButton(
                                title: "Add Product",
                                handler: () {
                                  submitForm(context);
                                },
                              )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
