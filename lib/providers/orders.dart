import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/cart_item.dart';
import '/models/order.dart';

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  Future<void> addToOrders(List<CartItem> products, double totalPrice) async {
    final url = Uri.parse(
        'https://online-shop-flutter-lessons-default-rtdb.firebaseio.com/orders.json');
    List orderProductId = [];
    products.forEach((product) {
      orderProductId.add(product.id);
    });
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          'totalPrice': totalPrice,
          'date': DateTime.now().toString(),
          'products': orderProductId,
        },
      ),
    );
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
