import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_tec/app.dart';
import 'package:shop_tec/src/data/data_repository.dart';
import 'package:shop_tec/src/themes/theme_provider.dart';
import 'package:shop_tec/src/data/auth_repository.dart';

import 'package:shop_tec/src/data/firestore_database.dart';
import 'package:shop_tec/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Instanziiere die Repositories
  DatabaseRepository databaseRepository =
      FirestoreDatabase(FirebaseFirestore.instance);
  AuthRepository authRepository = AuthRepository(FirebaseAuth.instance);

  runApp(
    MultiProvider(
      providers: [
        // Datenbank-Repository Provider
        Provider<DatabaseRepository>(
          create: (_) => databaseRepository,
        ),
        // Authentifizierungs-Repository Provider
        Provider<AuthRepository>(
          create: (_) => authRepository,
        ),
        // Theme Provider
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const App(),
    ),
  );
}
