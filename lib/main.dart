import 'dart:convert';
import 'dart:ffi';
import 'package:amazon_app/Features/Home/Services/home_services.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_app/Features/Auth/Screens/auth_screen.dart';
import 'package:amazon_app/Features/Auth/Widgets/login.dart';
import 'package:amazon_app/Features/Home/Screen/home_screen.dart';
import 'package:amazon_app/Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Future<dynamic> getVerify() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if (token == null) {
      return 'unauth';
    }
    // http.Response res = await HomeServices().verifyUser(token);
    // print("verify");
    // print(res);

    return 'auth';
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Amazon App',
        home: Scaffold(
          body: FutureBuilder(
            future: getVerify(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading"),
                );
              }

              var res = snapshot.data;
              print(res);

              if (res == 'unauth') {
                return AuthScreen();
              }
              return HomeScreen();
            },
          ),
        ),
      ),
    );
  }
}
