import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_tec/src/data/auth_repository.dart';
import 'package:shop_tec/src/data/data_repository.dart';
import 'package:shop_tec/src/features/cart/presentation/cart_page.dart';
import 'package:shop_tec/src/features/overview/domain/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final databaseRepository =
        Provider.of<DatabaseRepository>(context, listen: false);
    Provider.of<AuthRepository>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .32,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3E3C3C),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.shopping_cart,
                          color: Color.fromARGB(255, 191, 176, 42),
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.only(left: 270, top: 45),
                      child: Image.asset(
                        product.imageUrl,
                        width: 140,
                        height: 140,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 35,
            child: Text(
              product.name,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Positioned(
            top: 250,
            left: 35,
            child: Text(
              'Price: \$${product.price}',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(184, 75, 75, 1)),
            ),
          ),
          Positioned(
            top: 330,
            left: 130,
            child: SizedBox(
              width: 138,
              height: 64,
              child: Text(
                product.name,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Positioned(
            top: 400,
            left: 50,
            child: SizedBox(
              width: 328,
              height: 147,
              child: Text(
                product.description,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Positioned(
            left: 200,
            top: 580,
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/foto/Group 22.png',
                      width: 66,
                      height: 60,
                    ),
                    Image.asset('assets/foto/2.png'),
                  ],
                ),
                const Text(
                  'Waterproof',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 45,
            top: 580,
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/foto/Group 22.png',
                      width: 66,
                      height: 60,
                    ),
                    Image.asset(
                      'assets/foto/3.png',
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
                const Text(
                  'Beckup',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 45,
            top: 670,
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/foto/Group 22.png',
                      width: 66,
                      height: 60,
                    ),
                    Image.asset(
                      'assets/foto/1.png',
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
                const Text(
                  'Heart Rate',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 200,
            top: 670,
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/foto/Group 22.png',
                      width: 66,
                      height: 60,
                    ),
                    Image.asset(
                      'assets/foto/son.png',
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
                const Text(
                  'Weather',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 85,
            bottom: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 80.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                var repository =
                    Provider.of<DatabaseRepository>(context, listen: false);
                repository.addToCart(product);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product added to cart')),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(
                      databaseRepository: databaseRepository,
                    ),
                  ),
                );
              },
              child: Text(
                'Add to Cart',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
