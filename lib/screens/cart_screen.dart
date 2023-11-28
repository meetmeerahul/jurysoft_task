import 'package:flutter/material.dart';
import 'package:jurysoft_task/providers.dart';
import 'package:provider/provider.dart';

import '../consts/cat_list.dart';

import '../widgets/cart_list.dart';
import '../widgets/empty_cart.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final double total = Provider.of<TotalClass>(context).totalAmount;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        actions: [
          Row(
            children: [
              TextButton(
                  onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CheckoutScreen(),
                        ),
                      ),
                  child: cartList.isEmpty
                      ? const Text("")
                      : const Text(
                          "Checkout",
                          style: TextStyle(color: Colors.green),
                        ))
            ],
          )
        ],
      ),
      body: cartList.isEmpty
          ? const Center(
              child: EmptyCart(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: cartItems(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rs $total', // Assuming the total is in dollars
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
