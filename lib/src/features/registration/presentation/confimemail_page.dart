import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_tec/src/features/registration/presentation/succemail_page.dart';

class ConfimEmailPage extends StatelessWidget {
  final String email; // Make email dynamic

  const ConfimEmailPage({
    super.key,
    required this.email, // Accept email as a parameter
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
              children: [
                const SizedBox(height: 50),

                // Logo
                const Image(
                  image: AssetImage('assets/logo/logo.png'),
                ),
                const SizedBox(height: 50),

                // App Name
                Text(
                  'ProvisionTec Shop',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 42,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 70),

                // Email Verification Prompt
                Text(
                  'Verify your email address!',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 35,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 10),

                // User's Email Address
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(height: 10),

                // Verification Text
                Center(
                  child: Text(
                    'Congratulations! Your Account Awaits: Verify Your Email to Start Shopping and Experience a World of Unrivaled Deals and Personalized Offers.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Continue Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuccEmailPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
