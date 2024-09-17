import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';
import 'screens/menu_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pizzaria',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MenuScreen(),
    );
  }
}
