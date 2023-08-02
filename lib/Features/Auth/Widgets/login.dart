import 'package:amazon_app/Constants/styling.dart';
import 'package:amazon_app/Features/Auth/Services/auth_services.dart';
import 'package:amazon_app/Features/Auth/Widgets/custom_button.dart';
import 'package:amazon_app/Features/Home/Screen/home_screen.dart';
import 'package:amazon_app/Models/keypair.dart';
import 'package:amazon_app/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  final emailController;
  final passwordController;
  final _formState = GlobalKey<FormState>();

  Login({
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formState,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            style: getTexStyle(size: 16),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Email is empty";
              }
              if (!value!.contains('@gmail.com')) {
                return "Email Format badly";
              }
              return null;
            },
          ),
          Text(
            "Password",
            style: getTexStyle(size: 16),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Password is empty";
              }
              if (value!.length < 6) {
                return "Password Must contain at least 6 character.";
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          CustomButton(
              title: "Login",
              handler: () async {
                if (_formState.currentState!.validate()) {
                  KeyPair res = await AuthServices().signIn(
                      email: emailController.text,
                      password: passwordController.text);
                  if (res.key != 'error') {
                    var pref = await SharedPreferences.getInstance();
                    pref.setString('token', res.value);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) {
                        return HomeScreen();
                      }),
                    );
                  } else {
                    Utils.showToast(context, res.value);
                  }
                }
              }),
        ],
      ),
    );
  }
}
