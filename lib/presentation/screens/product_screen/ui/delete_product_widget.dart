import 'package:flutter/material.dart';

bool isOpen = false;

class DeleteProductWidget extends StatelessWidget {
  const DeleteProductWidget(
      {super.key, required this.delkey, required this.child});
  final Key delkey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: delkey,
        onUpdate: (details) {
          if (details.progress > 0.2 &&
              !isOpen &&
              details.direction == DismissDirection.endToStart) {
            confirmDelMessage(context);
          }
        },
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
        onDismissed: (direction) {
          // Handle deletion here
          // ref.read(productProvider).deleteProduct(product.id);
        },
        child: child);
  }

  Future<bool?> confirmDelMessage(BuildContext context) {
    isOpen = true;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Do you want to remove this item?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                isOpen = false;
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                isOpen = false;
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
