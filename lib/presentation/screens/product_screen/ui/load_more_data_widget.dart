import 'package:e_commerce_store/application/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadMoreDataWidget extends StatelessWidget {
  const LoadMoreDataWidget({
    super.key,
    required this.ref,
    required this.child,
  });

  final WidgetRef ref;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification.metrics.pixels ==
            scrollNotification.metrics.maxScrollExtent) {
          ref
              .read(productProvider)
              .loagMoreProducts(); // Fetch more data when reaching the end
        }
        return true;
      },
      child: RefreshIndicator.adaptive(
        onRefresh: () {
          return ref.read(productProvider).refreshProducts();
        },
        child: child,
      ),
    );
  }
}
