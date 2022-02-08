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
  var _init = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_init) {
      _isLoading = true;
      Provider.of<Products>(context, listen: false)
          .getProductsFromFirebase()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final producrsData = Provider.of<Products>(context);
    final products =
        widget.showFavorites ? producrsData.favorites : producrsData.list;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : products.isNotEmpty
            ? GridView.builder(
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
              )
            : const Center(
                child: Text('Maxsulotlar mavjud emas'),
              );
  }
}
