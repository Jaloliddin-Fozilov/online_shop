import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

import '../screens/home_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/manage_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text("Hello My Friend!"),
          ),
          ListTile(
            leading: const Icon(
              Icons.shop,
            ),
            title: const Text("Shop"),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(HomeScreen.routName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.payment,
            ),
            title: const Text("Buyurtmalar"),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.settings,
            ),
            title: const Text("Mahsulotlarni boshqarish"),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ManageProductScreen.routName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
            ),
            title: const Text("Chiqish"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
