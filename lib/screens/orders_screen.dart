import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';

import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routName = "/orders";

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Orders"),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orders.items.length,
        itemBuilder: (ctx, index) {
          final order = orders.items[index];

          return OrderItem(
            totalPrice: order.totalPrice,
            date: order.date,
            products: order.products,
          );
        },
      ),
    );
  }
}
