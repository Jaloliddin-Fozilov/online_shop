import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addToCart(
    String productId,
    String title,
    String image,
    double price,
  ) {
    if (_items.containsKey(productId)) {
      // mahsulot bo'lsa ++ bo'lish kerak
      _items.update(
        productId,
        (currentProduct) => CartItem(
            id: currentProduct.id,
            title: currentProduct.title,
            quantity: currentProduct.quantity + 1,
            price: currentProduct.price,
            image: currentProduct.image),
      );
    } else {
      // cartga qo'shish kerak
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: UniqueKey().toString(),
            title: title,
            quantity: 1,
            price: price,
            image: image),
      );
    }
  }
}
