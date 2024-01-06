import 'package:flutter/material.dart';

class DeleteProductWidget extends StatelessWidget {
  const DeleteProductWidget(
      {super.key, required this.delkey, required this.child});
  final Key delkey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: delkey,
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
          confirmDelMessage(context).then((value) {
            if (value!) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item removed'),
                ),
              );
            }
          });
        },
        child: child);
  }

  Future<bool?> confirmDelMessage(BuildContext context) {
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
