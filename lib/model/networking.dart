import 'dart:convert';

import 'package:product_api/model/model.dart';
import 'package:http/http.dart' as http;

class Networking {
  Future<List<Product>> getProductData() async {
    try {
      http.Response response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body) as List;
        List<Product> productData =
            data.map((json) => Product.fromJson(json)).toList();
        print(productData.first.id);
        return productData;
      } else {
        throw Exception(' Failed to load Data');
      }
    } catch (err) {
      print(err);
    }
    throw 'Erro';
  }
}
