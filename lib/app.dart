import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_tec/src/data/data_repository.dart';
import 'package:shop_tec/src/features/cart/presentation/cart_page.dart';

import 'package:shop_tec/src/features/registration/presentation/login_page.dart';
import 'package:shop_tec/src/features/shop%20page/presentation/shop_page.dart';
import 'package:shop_tec/src/themes/theme_provider.dart';
// ShopPage importiert

import 'src/data/auth_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const loginKey = ValueKey('loginScreen');
    const shopKey = ValueKey('shopScreen');

    return StreamBuilder(
      stream: context.read<AuthRepository>().authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data; // Authentifizierungsstatus abfragen

        return MaterialApp(
          key: user == null
              ? loginKey
              : shopKey, // Umschalten basierend auf dem Auth-Status
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ThemeProvider>(context)
              .themeData, // Dynamische Themes
          home: user == null ? const LoginPage() : const ShopPage(),
          routes: {
            '/cart_page': (context) => CartPage(
                  databaseRepository:
                      Provider.of<DatabaseRepository>(context, listen: false),
                ),
          },
        );
      },
    );
  }
}
