import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../services/http_expection.dart';

class Products with ChangeNotifier {
  List<Product> _list = [
    // Product(
    //   id: "p1",
    //   title: "Macbook Pro",
    //   description:
    //       "Ajoyib Macbook Pro | Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    //   price: 1700,
    //   imageUrl:
    //       "https://images.unsplash.com/photo-1580522154071-c6ca47a859ad?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
    // ),
    // Product(
    //   id: "p2",
    //   title: "iPhone 13 Pro max",
    //   description: "Ajoyib iPhone 13 Pro max",
    //   price: 1200,
    //   imageUrl:
    //       "https://images.unsplash.com/photo-1632661674596-df8be070a5c5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80",
    // ),
    // Product(
    //   id: "p3",
    //   title: "AirPods 4 pro",
    //   description: "AirPods 4 pro",
    //   price: 250,
    //   imageUrl:
    //       "https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1289&q=80",
    // ),
  ];

  List<Product> get list {
    return [..._list];
  }

  List<Product> get favorites {
    return _list.where((product) => product.isFavorite).toList();
  }

  Future<void> getProductsFromFirebase() async {
    final url = Uri.parse(
        'https://online-shop-flutter-lessons-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      if (jsonDecode(response.body) != null) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List<Product> loadedProducts = [];
        data.forEach((productId, productData) {
          loadedProducts.add(
            Product(
              id: productId,
              title: productData['title'],
              description: productData['description'],
              price: productData['price'],
              imageUrl: productData['imageUrl'],
              isFavorite: productData['isFavorite'],
            ),
          );
        });
        _list = loadedProducts;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://online-shop-flutter-lessons-default-rtdb.firebaseio.com/products.json');

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
          },
        ),
      );
      final name = (jsonDecode(response.body) as Map<String, dynamic>)['name'];
      final newProduct = Product(
        id: name,
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _list.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(Product updatedProduct) async {
    final productIndex =
        _list.indexWhere((product) => product.id == updatedProduct.id);
    if (productIndex >= 0) {
      final url = Uri.parse(
          'https://online-shop-flutter-lessons-default-rtdb.firebaseio.com/products/${updatedProduct.id}.json');
      try {
        await http.patch(
          url,
          body: jsonEncode(
            {
              'title': updatedProduct.title,
              'description': updatedProduct.description,
              'price': updatedProduct.price,
              'imageUrl': updatedProduct.imageUrl,
            },
          ),
        );

        _list[productIndex] = updatedProduct;
        notifyListeners();
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://online-shop-flutter-lessons-default-rtdb.firebaseio.com/products/$id.json');
    try {
      var deletingProduct = _list.firstWhere((product) => product.id == id);
      final productIndex = _list.indexWhere((product) => product.id == id);
      _list.removeWhere((product) => product.id == id);
      notifyListeners();

      final respone = await http.delete(url);
      if (respone.statusCode >= 400) {
        _list.insert(productIndex, deletingProduct);
        notifyListeners();
        throw HttpExpection('Kechirasiz, mahsulot o\'chirishda xatolik');
      }
    } catch (e) {
      rethrow;
    }
  }

  Product findById(String productId) {
    print(_list.firstWhere(
      (product) => product.id == productId,
    ));
    return _list.firstWhere(
      (product) => product.id == productId,
    );
  }
}
