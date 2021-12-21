import 'package:flutter/material.dart';
import 'package:online_shop/providers/products.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/product_detail_screen.dart';

import './style/online_shop_style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  ThemeData theme = OnlineShopStyle.theme;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Products>(
      create: (ctx) {
        return Products();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const HomeScreen(),
        routes: {
          ProductDetailScreen.routName: (ctx) => const ProductDetailScreen(),
        },
      ),
    );
  }
}
