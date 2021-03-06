import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

import '/screens/edit_product_screen.dart';

import '../providers/products.dart';

class ManageProductScreen extends StatelessWidget {
  const ManageProductScreen({Key? key}) : super(key: key);

  static const routName = '/manage-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .getProductsFromFirebase(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productProvider = Provider.of<Products>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Mahsulotlarni boshqarish"),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: Consumer<Products>(builder: (c, productProvider, _) {
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: productProvider.list.length,
                  itemBuilder: (ctx, index) {
                    final product = productProvider.list[index];
                    return ChangeNotifierProvider.value(
                      value: product,
                      child: const UserProductItem(),
                    );
                  },
                );
              }),
            );
          } else {
            return const Center(
              child: Text("Xatolik sodir bo'ldi!"),
            );
          }
        },
      ),
    );
  }
}
