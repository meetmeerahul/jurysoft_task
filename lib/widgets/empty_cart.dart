import 'package:flutter/material.dart';

class EmptyCart extends StatefulWidget {
  const EmptyCart({super.key});

  @override
  State<EmptyCart> createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart> {

  


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.shopping_bag,
          size: 80,
          color: Colors.black,
        ),
        Text(
          "Cart is Empty",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ],
    ));
  }
}
