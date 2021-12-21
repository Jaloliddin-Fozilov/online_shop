import 'package:flutter/material.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _list = [
    Product(
      id: "p1",
      title: "Macbook Pro",
      description: "Ajoyib Macbook Pro",
      price: 1700,
      imageUrl:
          "https://images.unsplash.com/photo-1580522154071-c6ca47a859ad?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
    ),
    Product(
      id: "p2",
      title: "iPhone 13 Pro max",
      description: "Ajoyib iPhone 13 Pro max",
      price: 1200,
      imageUrl:
          "https://images.unsplash.com/photo-1632661674596-df8be070a5c5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80",
    ),
    Product(
      id: "p3",
      title: "AirPods 4 pro",
      description: "AirPods 4 pro",
      price: 250,
      imageUrl:
          "https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1289&q=80",
    ),
  ];

  List<Product> get list {
    return [..._list];
  }
}
