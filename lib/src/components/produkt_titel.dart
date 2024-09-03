import 'package:flutter/material.dart';

class ProduktTitel extends StatelessWidget {
  final String imageUrl;
  const ProduktTitel({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/Rectangle 30.png',
        ),
        Positioned(
          top: 80,
          left: 68,
          child: Column(
            children: [
              Image.asset(
                imageUrl,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Rolex 1908',
                style:
                    TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                '18k White coki',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
