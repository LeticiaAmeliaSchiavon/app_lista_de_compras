import 'package:app_lista_de_compras/pages/home.page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Lista de Compras',
      debugShowCheckedModeBanner: false,
      home: const HomeListsPage(),
    );
  }
}
