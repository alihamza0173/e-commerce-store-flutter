import 'package:e_commerce_store/core/models/product.dart';
import 'package:flutter/material.dart';

class PriceAndRatingWidget extends StatelessWidget {
  const PriceAndRatingWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'SAR ${product.price}',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Row(
          children: [
            Text(
              product.rating.toString(),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 43, 90, 128),
              ),
            ),
            const SizedBox(width: 4.0),
            const Icon(Icons.star, color: Color.fromARGB(255, 43, 90, 128)),
          ],
        ),
      ],
    );
  }
}
