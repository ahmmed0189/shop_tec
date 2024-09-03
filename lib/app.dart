import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_tec/src/features/registration/presentation/login_page.dart';
import 'package:shop_tec/src/themes/theme_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
