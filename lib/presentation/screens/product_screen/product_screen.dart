import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_store/application/provider/internet_connectivity_provider.dart';
import 'package:e_commerce_store/application/provider/product_provider.dart';
import 'package:e_commerce_store/application/provider/settings_provider.dart';
import 'package:e_commerce_store/core/enums/product_provider_status.dart';
import 'package:e_commerce_store/presentation/screens/product_screen/ui/delete_product_widget.dart';
import 'package:e_commerce_store/presentation/screens/product_screen/ui/load_more_data_widget.dart';
import 'package:e_commerce_store/presentation/screens/product_screen/ui/price_and_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<ProductScreen> {
  late final StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    ref.read(productProvider).getProducts();
    ref.read(internetConnectivityProvider).init(context);
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(productProvider);
    final products = provider.products;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(settingsProvider).toggleThemeMode();
            },
            icon: Icon(
              ref.watch(settingsProvider).isDarkMode
                  ? Icons.brightness_7
                  : Icons.brightness_4,
            ),
          ),
        ],
      ),
      body: provider.status == ProductProviderStatus.loading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : provider.status == ProductProviderStatus.error
              ? Center(
                  child: Text(provider.errorMessage),
                )
              : products.isEmpty
                  ? const Center(
                      child: Text('No products found'),
                    )
                  : LoadMoreDataWidget(
                      child: ListView.builder(
                        itemCount: products.length + 1,
                        itemBuilder: (context, index) {
                          if (index < products.length) {
                            final product = products[index];
                            return DeleteProductWidget(
                              id: product.id,
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: CachedNetworkImage(
                                          imageUrl: product.thumbnail,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          width: screenWidth * 0.9,
                                          height: screenWidth * 0.5,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 12.0),
                                      PriceAndRatingWidget(product: product),
                                      SizedBox(
                                        width: screenWidth * 0.9,
                                        child: Text(
                                          product.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.9,
                                        child: Text(
                                          product.description,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                        },
                      ),
                    ),
    );
  }
}
