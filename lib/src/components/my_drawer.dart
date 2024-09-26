import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_tec/src/components/my_drawer_titel.dart';
import 'package:shop_tec/src/data/auth_repository.dart';
import 'package:shop_tec/src/data/data_repository.dart';
import 'package:shop_tec/src/features/cart/presentation/cart_page.dart'; // Füge den Import für CartPage hinzu
import 'package:shop_tec/src/features/profile/domain/profile_page.dart';
import 'package:shop_tec/src/features/registration/presentation/login_page.dart';
import 'package:shop_tec/src/features/shop%20page/presentation/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseRepository =
        Provider.of<DatabaseRepository>(context, listen: false);
    Provider.of<AuthRepository>(context, listen: false);
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Column(
        children: [
          // app logo
          const Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Image(
              image: AssetImage('assets/logo/logo.png'),
              width: 100,
              height: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          // home list titel
          MyDrawerTitel(
            text: "HOME",
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),
          // cart
          MyDrawerTitel(
            text: "Cart",
            icon: Icons.shopping_cart_sharp,
            onTap: () {
              Navigator.pop(context); // Schließt das Drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    databaseRepository:
                        databaseRepository, // Übergabe des Repositories
                  ),
                ),
              );
            },
          ),

          // settings list titel
          MyDrawerTitel(
            text: "SETTINGS",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          MyDrawerTitel(
            text: "Profile",
            icon: Icons.person,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),

          const Spacer(),
          //logout list
          MyDrawerTitel(
            text: "LOGOUT",
            icon: Icons.logout,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
