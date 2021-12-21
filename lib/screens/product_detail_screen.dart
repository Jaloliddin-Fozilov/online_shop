import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  static const routName = "/product-detail-screen";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments;
    final product = Provider.of<Products>(context, listen: false)
        .findById(productId as String);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.title),
      ),
    );
  }
}
