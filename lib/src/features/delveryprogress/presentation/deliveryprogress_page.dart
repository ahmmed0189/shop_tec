import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_tec/src/features/overview/domain/product.dart';

class DeliveryProgressPage extends StatefulWidget {
  final List<Product> products; // Liste der gekauften Produkte
  final double totalPrice; // Gesamtsumme

  const DeliveryProgressPage({
    required this.products,
    required this.totalPrice,
    super.key,
  });

  @override
  _DeliveryProgressPageState createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  String? username;
  String? address;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Lade Benutzerdaten von Firebase Auth und Firestore
  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        username = userData['username'];
        address = userData['address'];
      });

      // Nachdem Benutzerdaten geladen wurden, speichere Bestellung in Firestore
      _registerOrderInFirestore();
    }
  }

  // Bestelldaten in Firestore speichern
  Future<void> _registerOrderInFirestore() async {
    // Beispiel für eine Bestellung
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'username': username,
        'address': address,
        'products': widget.products
            .map((product) => {'name': product.name, 'price': product.price})
            .toList(),
        'totalPrice': widget.totalPrice,
        'orderDate': Timestamp.now(),
      });

      // Zeige Bestätigung an oder navigiere zu einer Dankesseite
      print("Order successfully registered!");
    } catch (e) {
      print("Failed to register order: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thank you for your order!',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 80),
            Text(
              'Username: ${username ?? 'Loading...'}',
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            Text(
              'Address: ${address ?? 'Loading...'}',
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            const Center(
              child: Text(
                '-------------------------------',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Ordered Products:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(height: 20),
            ...widget.products.map((product) => Text(
                '${product.name} - \$${product.price.toStringAsFixed(2)}')),
            const Center(
              child: Text(
                '-------------------------------',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Total Price: \$${widget.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
