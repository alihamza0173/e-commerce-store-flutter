import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_store/application/services/product_service.dart';
import 'package:e_commerce_store/core/enums/product_provider_status.dart';
import 'package:e_commerce_store/core/models/product.dart';
import 'package:e_commerce_store/core/repostries/product_repositry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepositry _productRepositry;

  ProductProvider(this._productRepositry);
  final List<Product> _products = [];
  int _skipProducts = 0;
  bool _isLoading = false;
  final String _key = 'products';
  bool _isCachedDataRetreived = false;
  ProductProviderStatus _status = ProductProviderStatus.loading;
  String _errorMessage = '';

  List<Product> get products => _products;
  ProductProviderStatus get status => _status;
  String get errorMessage => _errorMessage;

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> getProducts() async {
    if (await checkInternetConnectivity()) {
      try {
        final value = await _productRepositry.getProducts(_skipProducts);
        _products.addAll(value);
        cacheProducts(_products);
        _skipProducts < 90 ? _skipProducts += 10 : _skipProducts = 0;
        _status = ProductProviderStatus.loaded;
      } catch (e) {
        log('Error getting products: $e');
        _status = ProductProviderStatus.error;
        _errorMessage = 'Error getting products';
      }
    } else if (!_isCachedDataRetreived) {
      _products.addAll(await getCachedProducts());
      _status = ProductProviderStatus.loaded;
    }
    notifyListeners();
  }

  void deleteProduct(int id) {
    _products.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> cacheProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedProducts =
        products.map((product) => product.toJson()).toList();
    final jsonString = jsonEncode(encodedProducts);
    await prefs.setString(_key, jsonString);
  }

  Future<List<Product>> getCachedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      _isCachedDataRetreived = true;
      final decoded = jsonDecode(jsonString) as List<dynamic>;
      return decoded.map((e) => Product.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> loadMoreProducts() async {
    if (!_isLoading) {
      _isLoading = true;
      getProducts().then((value) => _isLoading = false);
    }
  }

  Future<void> refreshProducts() async {
    _products.clear();
    _isCachedDataRetreived = false;
    getProducts();
  }
}

final productProvider = ChangeNotifierProvider(
  (ref) => ProductProvider(ProductService()),
);
