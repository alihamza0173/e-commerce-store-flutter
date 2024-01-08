import 'package:e_commerce_store/application/provider/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteProductWidget extends ConsumerWidget {
  const DeleteProductWidget({super.key, required this.id, required this.child});
  final int id;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
        key: Key(id.toString()),
        background: Container(
          color: Colors.red, // Swipe background color
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return await confirmDelMessage(context);
        },
        onDismissed: (direction) {
          ref.read(productProvider).deleteProduct(id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item removed'),
            ),
          );
        },
        child: child);
  }

  Future<bool?> confirmDelMessage(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Do you want to remove this item?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
