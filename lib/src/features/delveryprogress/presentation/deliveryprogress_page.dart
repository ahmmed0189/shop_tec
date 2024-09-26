import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_tec/src/components/button.dart';
import 'package:shop_tec/src/components/my_order.dart';
import 'package:shop_tec/src/features/overview/domain/product.dart';
import 'package:shop_tec/src/features/shop%20page/presentation/shop_page.dart';

class DeliveryProgressPage extends StatefulWidget {
  final String userId; // User ID to fetch profile data
  final List<Product> orderedProducts; // List of products ordered
  final double totalPrice; // Total price of the order
  final String username; // Added username
  final String address; // Added address

  const DeliveryProgressPage({
    required this.userId,
    required this.orderedProducts,
    required this.totalPrice,
    required this.username,
    required this.address,
    super.key,
  });

  @override
  _DeliveryProgressPageState createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  bool isLoading = true; // Loading state
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    // Simulate loading delay if needed
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false; // Update loading state
      });
    });
    // Call the function to save delivery progress
    saveDeliveryProgress();
  }

  Future<void> saveDeliveryProgress() async {
    try {
      // Here, we are just taking the first product's ID as an example.
      // You may want to customize this further.
      String productId = widget.orderedProducts.isNotEmpty
          ? widget.orderedProducts.first.id
          : '';

      await _firestore.collection('deliveries').add({
        'userId': currentUser.uid,
        'username': currentUser.displayName ?? currentUser.email,
        'address': widget.address.hashCode,
        'productId': productId,
        'totalPrice': widget.totalPrice,
      });
      print("Delivery progress saved successfully!");
    } catch (e) {
      print("Error saving delivery progress: $e");
    }
  }

  // StreamBuilder für die Lieferhistorie
  Widget buildDeliveryHistory() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('deliveries')
          .where('userId', isEqualTo: widget.userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading deliveries'));
        }

        final deliveries = snapshot.data?.docs ?? [];

        if (deliveries.isEmpty) {
          return const Center(child: Text('No deliveries found'));
        }

        return ListView.builder(
          itemCount: deliveries.length,
          itemBuilder: (context, index) {
            var deliveryData = deliveries[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(deliveryData['username']),
              subtitle: Text(
                  '${deliveryData['address']}\nTotal: \$${deliveryData['totalPrice']}'),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Delivery in progress.."),
        ),
        body: const Center(child: CircularProgressIndicator()), // Show loading
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Delivery in progress.."),
      ),
      body: Column(
        children: [
          MyOrder(
            username: widget.username,
            address: widget.address,
            orderedProducts: widget.orderedProducts,
            totalPrice: widget.totalPrice,
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Delivery History:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: buildDeliveryHistory()), // Display delivery history
          Button(
            ontap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShopPage(),
              ),
            ),
            text: "confirm", // Button zeigt die Summe
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
