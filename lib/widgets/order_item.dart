import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/cart_item.dart';

class OrderItem extends StatefulWidget {
  final double totalPrice;
  final DateTime date;
  final List<CartItem> products;
  const OrderItem({
    Key? key,
    required this.totalPrice,
    required this.date,
    required this.products,
  }) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expandedItem = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.totalPrice}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.date)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expandedItem = !_expandedItem;
                });
              },
              icon: Icon(
                _expandedItem ? Icons.expand_less : Icons.expand_more,
              ),
            ),
          ),
          if (_expandedItem)
            Container(
              padding: const EdgeInsets.all(5),
              height: min(widget.products.length * 20 + 40, 100),
              child: ListView.builder(
                itemExtent: 40,
                itemCount: widget.products.length,
                itemBuilder: (ctx, index) {
                  final product = widget.products[index];
                  return ListTile(
                    title: Text(product.title),
                    trailing: Text(
                      '${product.quantity}x \$${product.price}',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
