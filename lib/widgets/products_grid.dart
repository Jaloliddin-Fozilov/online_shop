import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import 'product_item.dart';

class ProductsGrid extends StatefulWidget {
  final bool showFavorites;
  ProductsGrid(
    this.showFavorites, {
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  late Future _productFuture;
  Future _getProductsFuture() {
    return Provider.of<Products>(context, listen: false)
        .getProductsFromFirebase();
  }

  @override
  void initState() {
    _productFuture = _getProductsFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _productFuture,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (dataSnapshot.error == null) {
            return Consumer<Products>(builder: (c, products, child) {
              final ps =
                  widget.showFavorites ? products.favorites : products.list;
              return ps.isNotEmpty
                  ? GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 3 / 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      itemCount: ps.length,
                      itemBuilder: (ctx, index) {
                        return ChangeNotifierProvider.value(
                          value: ps[index],
                          child: const ProductItem(),
                        );
                      },
                    )
                  : const Center(
                      child: Text('Maxsulotlar mavjud emas'),
                    );
            });
          } else {
            return const Center(
              child: Text('Xatolik sodir bo\'ldi'),
            );
          }
        }
      },
    );
  }
}
