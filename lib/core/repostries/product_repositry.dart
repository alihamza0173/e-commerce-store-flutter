import 'package:e_commerce_store/core/models/product.dart';

abstract class ProductRepositry {
  Future<List<Product>> getProducts();
}
