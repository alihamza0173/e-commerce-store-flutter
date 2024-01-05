import 'package:e_commerce_store/application/provider/settings_provider.dart';
import 'package:e_commerce_store/application/router/app_router.dart';
import 'package:e_commerce_store/application/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce Store',
      routerConfig: appRouter.router,
      themeMode: ref.watch(settingsProvider).themeMode,
      theme: AppTheme.lightMode,
      darkTheme: AppTheme.darkMode,
    );
  }
}
