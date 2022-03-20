import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/cart.dart';
import './providers/products.dart';
import './providers/orders.dart';

import './screens/home_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/manage_products_screen.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';

import './style/online_shop_style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  ThemeData theme = OnlineShopStyle.theme;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: ((ctx) => Auth()),
        ),
        ChangeNotifierProvider<Products>(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider<Orders>(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const AuthScreen(),
        routes: {
          HomeScreen.routName: (ctx) => const HomeScreen(),
          ProductDetailScreen.routName: (ctx) => const ProductDetailScreen(),
          CartScreen.routName: (ctx) => const CartScreen(),
          OrdersScreen.routName: (ctx) => const OrdersScreen(),
          ManageProductScreen.routName: (ctx) => const ManageProductScreen(),
          EditProductScreen.routName: (ctx) => const EditProductScreen(),
        },
      ),
    );
  }
}
