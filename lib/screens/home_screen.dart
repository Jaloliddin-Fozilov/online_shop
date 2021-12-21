import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Online Shop"),
      ),
      body: const ProductsGrid(),
    );
  }
}
