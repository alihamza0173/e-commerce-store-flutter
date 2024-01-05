import 'package:e_commerce_store/application/services/product_service.dart';
import 'package:e_commerce_store/core/models/product.dart';
import 'package:e_commerce_store/core/repostries/product_repositry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepositry _productRepositry;

  ProductProvider(this._productRepositry);
  final List<Product> _products = [];

  List<Product> get products => _products;

  void getProducts() {
    _productRepositry.getProducts().then((value) {
      _products.addAll(value);
      notifyListeners();
    });
  }
}

final productProvider = ChangeNotifierProvider(
  (ref) => ProductProvider(ProductService()),
);
