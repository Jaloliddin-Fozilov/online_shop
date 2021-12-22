import 'package:flutter/material.dart';

class CustomCart extends StatelessWidget {
  final Widget child;
  final String number;
  const CustomCart({Key? key, required this.child, required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          top: 15,
          right: 10,
          child: Container(
            alignment: Alignment.center,
            width: 10,
            height: 10,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
            child: Text(
              number,
              style: TextStyle(
                fontSize: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
