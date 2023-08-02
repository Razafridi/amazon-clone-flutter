import 'dart:convert';
import 'dart:io';
import 'package:amazon_app/Constants/error_handling.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import '../../../Constants/global_variable.dart';

class ProductServices {
  Future<String> addProduct({
    required String category,
    required String userId,
    required String name,
    required String desctiption,
    required String price,
    required String quantity,
    required File image,
  }) async {
    try {
      var cloudinary = CloudinaryPublic('dpfbbxshr', 'buthd2gd');

      var res = await cloudinary
          .uploadFile(CloudinaryFile.fromFile(image.path, folder: "product"));
      var imageUrl = res.secureUrl;
      print(imageUrl);

      //Sending http request after successfully iploaded file
      http.Response result = await http.post(
        Uri.parse('${GlobalVariable.uri}/seller/add-product'),
        headers: {
          'Content-Type': 'application/json',
          'token': userId,
        },
        body: jsonEncode({
          'name': name,
          'description': desctiption,
          'price': double.parse(price),
          'productQuantity': double.parse(quantity),
          'image': imageUrl,
          'category': category,
        }),
      );

      if (result.statusCode != 200) {
        var error = ErrorHandling.NetworkError(result);
        return error;
      }
      return 'success';
    } catch (e) {
      print(e.toString());
      return 'error';
    }
  }
}
