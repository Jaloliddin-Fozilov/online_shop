import 'package:flutter/widgets.dart';

import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int itemsCount() {
    return _items.length;
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach(
      (key, cartItem) {
        total += cartItem.price * cartItem.quantity;
      },
    );
    return total;
  }

  void addToCart(
    String productId,
    String title,
    String image,
    double price,
  ) {
    if (_items.containsKey(productId)) {
      // mahsulot bo'lsa + 1 bo'lish kerak
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
    notifyListeners();
  }
}
