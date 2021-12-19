import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String image;
  final String title;
  const ProductItem({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline),
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_sharp,
            ),
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
