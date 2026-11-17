import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/constants.dart';
import '../models/product.dart';

class ApiService {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(kProductsUrl));
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat produk (${response.statusCode})');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final list = data['products'] as List;
    return list
        .map((e) => Product.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }
}
