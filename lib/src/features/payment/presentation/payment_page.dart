import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:shop_tec/src/components/button.dart';
import 'package:shop_tec/src/features/delveryprogress/presentation/deliveryprogress_page.dart';
import 'package:shop_tec/src/features/overview/domain/product.dart';

class PaymentPage extends StatefulWidget {
  final List<Product> cart; // Cart parameter
  final double totalPrice; // Total price parameter
  final String username; // Username parameter
  final String address; // Address parameter
  final String userId; // User ID parameter to fetch user profile

  const PaymentPage({
    required this.cart,
    required this.totalPrice,
    required this.username,
    required this.address,
    required this.userId,
    super.key,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  // This method is called when the user taps "Pay now"
  void userTappedPay() {
    // Validate the form before proceeding
    if (formKey.currentState?.validate() ?? false) {
      // Show a confirmation dialog before navigating to DeliveryProgressPage
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirm payment"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Card Number: $cardNumber"),
                Text("Expiry Date: $expiryDate"),
                Text("Card Holder Name: $cardHolderName"),
                Text("CVV: $cvvCode"),
              ],
            ),
          ),
          actions: [
            // Cancel button to dismiss the dialog
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            // Yes button to proceed with the payment and navigate
            TextButton(
              onPressed: () {
                // Navigate to DeliveryProgressPage with correct data
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryProgressPage(
                        products: widget.cart, // Übergibt die Produktliste
                        totalPrice:
                            widget.totalPrice, // Übergibt den Gesamtpreis),
                      ),
                    ));
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Credit card widget to display entered details
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (p0) {},
            ),
            // Credit card form for user input
            CreditCardForm(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: (data) {
                setState(() {
                  cardNumber = data.cardNumber;
                  expiryDate = data.expiryDate;
                  cardHolderName = data.cardHolderName;
                  cvvCode = data.cvvCode;
                });
              },
              formKey: formKey,
            ),
            const Spacer(),
            // Pay now button
            Button(ontap: userTappedPay, text: "Pay now"),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
