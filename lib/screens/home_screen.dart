import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/custom_cart.dart';
import '../widgets/app_drawer.dart';

import '../screens/cart_screen.dart';

import '../providers/cart.dart';

enum FilterOptions {
  Favorites,
  All,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routName = "/home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Online Shop"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions filter) {
              setState(
                () {
                  if (filter == FilterOptions.All) {
                    // showAll
                    _showOnlyFavorite = false;
                  } else {
                    // showFavorites
                    _showOnlyFavorite = true;
                  }
                },
              );
            },
            itemBuilder: (ctx) {
              return const [
                PopupMenuItem(
                  child: Text("Barchasi"),
                  value: FilterOptions.All,
                ),
                PopupMenuItem(
                  child: Text("Sevimli"),
                  value: FilterOptions.Favorites,
                ),
              ];
            },
          ),
          Consumer<Cart>(
            builder: (ctx, cart, child) {
              return CustomCart(
                child: child!,
                number: cart.itemsCount().toString(),
              );
            },
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routName),
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorite),
    );
  }
}
