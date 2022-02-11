import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../providers/products.dart';

import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routName = "/orders";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      Provider.of<Orders>(context, listen: false).getOrdersFromFirebase();
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Orders"),
      ),
      drawer: const AppDrawer(),
      body: orders.items.isNotEmpty
          ? ListView.builder(
              itemCount: orders.items.length,
              itemBuilder: (ctx, index) {
                final order = orders.items[index];
                final products =
                    Provider.of<Products>(context).findById(order.id);
                print(products);

                return OrderItem(
                  totalPrice: order.totalPrice,
                  date: order.date,
                  products: order.products,
                );
              },
            )
          : const Center(
              child: Text("Hali mahsulotlarga buyurtma bermagansiz."),
            ),
    );
  }
}
