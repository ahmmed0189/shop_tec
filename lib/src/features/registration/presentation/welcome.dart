import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_tec/src/components/my_button.dart';
import 'package:shop_tec/src/features/shop%20page/presentation/shop_page.dart';

class WelcomeToTec extends StatelessWidget {
  // Attribute

  // Konstruktor
  const WelcomeToTec({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // logo
              children: [
                const SizedBox(
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/logo/logo.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Welcome to',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 42,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'ProvisionTec Shop',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 42,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 10),
                MyButton(
                  ontap: () {},
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShopPage()),
                      );
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
