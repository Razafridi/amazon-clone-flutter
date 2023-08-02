import 'dart:convert';
import 'package:amazon_app/Constants/error_handling.dart';
import 'package:amazon_app/Constants/global_variable.dart';
import 'package:amazon_app/Models/keypair.dart';
import 'package:amazon_app/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  Future<KeyPair> singUp({
    required String name,
    required String email,
    required String password,
  }) async {
    http.Response res = await http.post(
      Uri.parse('${GlobalVariable.uri}/api/signup'),
      headers: {'Content-Type': 'application/json'}, // Add this header
      body: jsonEncode({
        'name': name,
        'password': password,
        'email': email,
        'type': 'user',
      }),
    );
    print(jsonDecode(res.body));
    String error = "error";
    if (res.statusCode != 200) {
      return KeyPair('error', ErrorHandling.NetworkError(res));
    }
    var data = jsonDecode(res.body);

    return KeyPair('token', data['token']);
  }

  //Sign in

  Future<KeyPair> signIn(
      {required String email, required String password}) async {
    http.Response res = await http.post(
        Uri.parse(
          '${GlobalVariable.uri}/api/signin',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }));

    // print(jsonDecode(res.body));
    String error = "error";
    if (res.statusCode != 200) {
      return KeyPair('error', ErrorHandling.NetworkError(res));
    }
    var data = jsonDecode(res.body);

    return KeyPair('token', data['token']);
  }
}
