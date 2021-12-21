import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;
  ProductsGrid(
    this.showFavorites, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final producrsData = Provider.of<Products>(context);
    final products = showFavorites ? producrsData.favorites : producrsData.list;
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: products.length,
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: const ProductItem(),
        );
      },
    );
  }
}
