import 'package:dio/dio.dart';
import 'package:e_commerce_store/application/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  final dio = Dio();

  dio.interceptors.add(LogInterceptor(responseBody: true));

  dio.interceptors.add(InterceptorsWrapper(
    onError: (DioException e, handler) {
      if (e.response?.statusCode == 404) {}
      return handler.next(e);
    },
  ));

  runApp(const ProviderScope(child: MainApp()));
}
