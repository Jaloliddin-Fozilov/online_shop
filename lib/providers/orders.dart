import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '/models/order.dart';

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  void addToOrders(List<CartItem> products, double totalPrice) {
    _items.insert(
      0,
      Order(
        id: UniqueKey().toString(),
        totalPrice: totalPrice,
        date: DateTime.now(),
        products: products,
      ),
    );
    notifyListeners();
  }
}
