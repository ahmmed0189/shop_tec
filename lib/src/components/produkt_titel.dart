import 'package:flutter/material.dart';
import 'package:shop_tec/src/features/overview/domain/product.dart';

import 'package:shop_tec/src/features/shop%20page/presentation/product_detaills_page.dart';

class ProduktTitel extends StatelessWidget {
  final Product product;

  const ProduktTitel({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigiere zur Detailseite
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Stack(
        children: [
          Image.asset('assets/images/Rectangle 30.png'), // Hintergrundbild
          Positioned(
            top: 80,
            left: 68,
            child: Column(
              children: [
                Image.asset(
                  product.imageUrl, // Dynamisches Produktbild
                  width: 150, // Bildgröße anpassen, falls nötig
                  height: 150,
                ),
                const SizedBox(height: 10),
                Text(
                  product.name, // Dynamischer Produktname
                  style: const TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
