import 'package:flutter/material.dart';
import 'package:shop_tec/src/components/button.dart';
import 'package:shop_tec/src/data/data_repository.dart';
import 'package:shop_tec/src/features/overview/domain/product.dart';
import 'package:shop_tec/src/features/payment/presentation/payment_page.dart';

class CartPage extends StatefulWidget {
  final DatabaseRepository databaseRepository;

  const CartPage({required this.databaseRepository, super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Product> cart;

  @override
  void initState() {
    cart = widget.databaseRepository.cart;
    super.initState();
  }

  void removeItemFromCart(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Remove this item from your cart?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.databaseRepository.removeFromCart(product);
                Navigator.pop(context);
              });
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  // Berechne die Gesamtsumme der Produkte im Warenkorb
  double calculateTotalPrice() {
    return cart.fold(0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = calculateTotalPrice(); // Berechne die Summe

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                cart.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text("Cart is empty.."),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            final item = cart[index];
                            return ListTile(
                              leading: Image.asset(
                                item.imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(item.name),
                              subtitle:
                                  Text('\$${item.price.toStringAsFixed(2)}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () =>
                                    removeItemFromCart(context, item),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
          // Zeige die Gesamtsumme an
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}', // Summe anzeigen
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          // Button zum Checkout
          Button(
            ontap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentPage(
                  cart: cart, // Übergibt die Produkte
                  totalPrice: totalPrice, // Übergibt den Gesamtpreis
                  username: '', // Füge Benutzernamen hinzu
                  address: '', // Füge Adresse hinzu
                  userId: '', // Übergibt die User-ID
                ),
              ),
            ),
            text:
                "Go To Checkout (\$${totalPrice.toStringAsFixed(2)})", // Button zeigt die Summe
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
