import 'dart:convert';

import 'package:amazon_app/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ErrorHandling {
  static String NetworkError(http.Response res) {
    if (res.statusCode == 400) {
      return jsonDecode(res.body)['message'];
    }
    if (res.statusCode == 500) {
      return jsonDecode(res.body)['error'];
    }

    return "Error Occur";
  }
}
