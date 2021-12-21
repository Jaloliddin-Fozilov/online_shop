import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
              setState(() {
                if (filter == FilterOptions.All) {
                  // showAll
                  _showOnlyFavorite = false;
                } else {
                  // showFavorites
                  _showOnlyFavorite = true;
                }
              });
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
        ],
      ),
      body: ProductsGrid(_showOnlyFavorite),
    );
  }
}
