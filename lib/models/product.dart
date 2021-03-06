import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleLike(String token, String userId) async {
    var oldfavorite = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url = Uri.parse(
        'https://online-shop-flutter-lessons-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token');
    try {
      final respone = await http.put(
        url,
        body: jsonEncode(
          isFavorite,
        ),
      );
      if (respone.statusCode >= 400) {
        isFavorite = oldfavorite;
        notifyListeners();
      }
    } catch (e) {
      isFavorite = oldfavorite;
      notifyListeners();
    }
  }
}
