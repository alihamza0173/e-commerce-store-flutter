import 'package:e_commerce_store/application/provider/internet_connectivity_provider.dart';
import 'package:e_commerce_store/application/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadMoreDataWidget extends ConsumerWidget {
  const LoadMoreDataWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInterntConnected =
        ref.watch(internetConnectivityProvider).isConnected;
    debugPrint('isInterntConnected: $isInterntConnected');
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent &&
            isInterntConnected) {
          ref
              .read(productProvider)
              .loagMoreProducts(); // Fetch more data when reaching the end
        }
        return true;
      },
      child: RefreshIndicator.adaptive(
        onRefresh: () {
          if (isInterntConnected) {
            return ref.read(productProvider).refreshProducts();
          } else {
            return Future.value();
          }
        },
        child: child,
      ),
    );
  }
}
