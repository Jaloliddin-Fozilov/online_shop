import 'package:flutter/material.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: HomeScreen(),
      routes: {
        ProductDetailScreen.routName: (ctx) => const ProductDetailScreen(),
      },
    );
  }
}
