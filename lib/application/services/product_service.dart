import 'package:dio/dio.dart';
import 'package:e_commerce_store/core/models/product.dart';
import 'package:e_commerce_store/core/repostries/product_repositry.dart';
import 'package:flutter/material.dart';

class ProductService extends ProductRepositry {
  final Dio _dio = Dio();

  @override
  Future<List<Product>> getProducts(int skipProducts) async {
    try {
      final response = await _dio
          .get('https://dummyjson.com/products?skip=$skipProducts&limit=10');
      final products = response.data as Map<String, dynamic>;
      final listOfProducts = products['products'] as List<dynamic>;
      return listOfProducts
          .map((e) => Product.fromJson(e))
          .cast<Product>()
          .toList();
    } catch (e) {
      debugPrint('Error fetching products: $e');
      rethrow;
    }
  }
}
