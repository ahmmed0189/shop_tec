/*import 'package:flutter/material.dart';
import 'package:shop_tec/src/features/overview/domain/product.dart';

class MyOrder extends StatelessWidget {
  final String username;
  final String address;
  final List<Product> orderedProducts;
  final double totalPrice;

  const MyOrder({
    required this.username,
    required this.address,
    required this.orderedProducts,
    required this.totalPrice,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thank you for your order!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text("Username: $username",
              style: const TextStyle(
                  fontSize: 18)), // Make sure username is being passed
          const SizedBox(height: 10),
          Text("Address: $address",
              style: const TextStyle(
                  fontSize: 18)), // Make sure address is being passed
          const SizedBox(height: 20),
          const Text(
            "Ordered Products:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...orderedProducts
              .map((product) => Text(
                    "${product.name} - \$${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 16),
                  ))
              .toList(),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          Text(
            "Total Price: \$${totalPrice.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}*/
