import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'models/loyalty_card.dart';
import 'providers/card_provider.dart';
import 'screen/home_screen.dart';

Future<void> main() async {
  // Initialize Hive and register adapter
  await Hive.initFlutter();
  Hive.registerAdapter(LoyaltyCardAdapter());

  // Open the Hive box for storing loyalty cards
  await Hive.openBox<LoyaltyCard>('cards');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CardProvider()),
      ],
      child: MaterialApp(
        title: 'Loyalty Card Storage',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}