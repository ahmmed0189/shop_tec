import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'package:shop_tec/src/components/my_drawer.dart';
import 'package:shop_tec/src/components/produkt_titel.dart';
import 'package:shop_tec/src/data/data_repository.dart';
import 'package:shop_tec/src/features/overview/domain/product.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Zugriff auf den DatabaseRepository innerhalb von build
    final databaseRepository = Provider.of<DatabaseRepository>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const MyDrawer(),
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          Positioned(
            left: 275,
            top: -6,
            child: Image.asset('assets/images/Rectangle 28.png'),
          ),
          Positioned(
            left: 37,
            top: 120,
            child: Text(
              'Featured',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 37,
            top: 155,
            child: Text(
              'Products',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 32,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 72,
            top: 234,
            child: Container(
              width: 14,
              height: 14,
              decoration: const ShapeDecoration(
                color: Color(0xFFDFB555),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 45,
            top: 241,
            child: Image.asset(
              'assets/images/Line 6.png',
              width: 22,
            ),
          ),
          Positioned(
            left: 40,
            top: 248,
            child: Container(
              width: 14,
              height: 14,
              decoration: const ShapeDecoration(
                color: Color(0xFFDFB555),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 58,
            top: 253,
            child: Image.asset(
              'assets/images/Line 6.png',
              width: 22,
            ),
          ),
          Positioned(
            left: 72,
            top: 262,
            child: Container(
              width: 14,
              height: 14,
              decoration: const ShapeDecoration(
                color: Color(0xFFDFB555),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 45,
            top: 268,
            child: Image.asset(
              'assets/images/Line 6.png',
              width: 22,
            ),
          ),
          Positioned(
            left: 136,
            top: 224,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/foto/Group 21.png',
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
          ),
          Positioned(
            left: 217,
            top: 224,
            child: Stack(
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
          ),
          Positioned(
            left: 298,
            top: 224,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/foto/Group 22.png',
                  width: 66,
                  height: 60,
                ),
                Image.asset('assets/foto/1.png'),
              ],
            ),
          ),
          Positioned(
            left: 63,
            top: 350,
            child: SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width - 60,
              child: FutureBuilder<List<Product>>(
                future: databaseRepository
                    .getProducts(), // Produkte aus Datenbank laden
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error);
                  } else if (snapshot.hasData) {
                    List<Product> products = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: ProduktTitel(product: products[index]),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No products available'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 237, 236, 236),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: GNav(
          rippleColor: const Color.fromARGB(255, 157, 25, 25),
          hoverColor: const Color.fromARGB(255, 119, 86, 86),
          haptic: true,
          tabBorderRadius: 15,
          tabActiveBorder: Border.all(color: Colors.black, width: 1),
          tabBorder: Border.all(color: Colors.grey, width: 1),
          tabShadow: [
            BoxShadow(
                color: const Color.fromARGB(255, 106, 139, 94).withOpacity(0.5),
                blurRadius: 8)
          ],
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 900),
          gap: 8,
          color: Colors.grey[800],
          activeColor: Colors.purple,
          iconSize: 24,
          tabBackgroundColor: Colors.purple.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Setting',
            ),
            GButton(
              icon: Icons.usb,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
