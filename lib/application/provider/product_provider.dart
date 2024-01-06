import 'package:e_commerce_store/application/services/product_service.dart';
import 'package:e_commerce_store/core/models/product.dart';
import 'package:e_commerce_store/core/repostries/product_repositry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepositry _productRepositry;

  ProductProvider(this._productRepositry);
  final List<Product> _products = [];
  int _skipProducts = 0;
  bool _isLoading = false;

  List<Product> get products => _products;

  Future<void> getProducts() async {
    _productRepositry.getProducts(_skipProducts).then((value) {
      _products.addAll(value);
      _skipProducts < 90 ? _skipProducts += 10 : _skipProducts = 0;
      notifyListeners();
    });
  }

  Future<void> loagMoreProducts() async {
    if (!_isLoading) {
      _isLoading = true;
      getProducts().then((value) => _isLoading = false);
    }
  }

  Future<void> refreshProducts() async {
    _products.clear();
    getProducts();
  }
}

final productProvider = ChangeNotifierProvider(
  (ref) => ProductProvider(ProductService()),
);
