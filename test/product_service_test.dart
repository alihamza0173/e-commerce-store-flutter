import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:e_commerce_store/application/services/product_service.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('ProductService Tests', () {
    late ProductService productService;
    late Dio mockDio;

    setUp(() {
      mockDio = MockDio();
      productService = ProductService();
    });

    RequestOptions options = RequestOptions(
      method: 'GET', // or 'POST', 'PUT', 'DELETE', etc.
      baseUrl: 'https://dummyjson.com',
      path: '/products',
      queryParameters: {'skip': 0, 'limit': 10},
    );

    test('Test getProducts() success', () async {
      // Mock the successful response from the network
      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
            data: {
              'products': [
                {'id': 1, 'name': 'Product 1', 'price': 20},
                // Other mocked product data
              ]
            },
            statusCode: 200,
            requestOptions: options,
          ));

      // Call the method and assert the returned value
      final products = await productService.getProducts(0);
      expect(products.length, equals(1)); // Adjust the expected length

      // Verify that Dio was called with the correct URL
      verify(() =>
              mockDio.get('https://dummyjson.com/products?skip=0&limit=10'))
          .called(1);
    });

    test('Test getProducts() failure', () async {
      // Mock a failed response from the network
      when(() => mockDio.get(any()))
          .thenThrow(DioException(requestOptions: options));

      // Call the method and expect it to throw an exception
      expect(() async => await productService.getProducts(0), throwsException);
    });
  });
}
