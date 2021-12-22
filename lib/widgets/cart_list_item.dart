import 'package:flutter/material.dart';

class CartListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final int quantity;
  const CartListItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            imageUrl,
          ),
        ),
        title: Text(
          title,
        ),
        subtitle: Text('Umumiy: \$${(price * quantity).toStringAsFixed(2)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: const Icon(
                Icons.remove,
                color: Colors.black,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
              ),
              child: Text('$quantity'),
            ),
            IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
