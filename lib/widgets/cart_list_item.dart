import 'package:flutter/material.dart';
import 'package:jurysoft_task/consts/cat_list.dart';

import 'package:jurysoft_task/providers.dart';
import 'package:provider/provider.dart';

class CartListItem extends StatefulWidget {
  const CartListItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  @override
  Widget build(BuildContext context) {
    // print(total.value);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(
          cartList[widget.index].image.toString(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              cartList[widget.index].title.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              cartList[widget.index].total.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (cartList[widget.index].qualtity! > 1) {
                    cartList[widget.index].total =
                        cartList[widget.index].total! -
                            cartList[widget.index].price!;

                    cartList[widget.index].qualtity =
                        cartList[widget.index].qualtity! - 1;

                    Provider.of<TotalClass>(context, listen: false).removeItem(
                        cartList[widget.index].price!.toDouble(), 1);
                  }
                });
              },
              child: const Text(
                "-",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Text(
              cartList[widget.index].qualtity.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  cartList[widget.index].total = cartList[widget.index].total! +
                      cartList[widget.index].price!;

                  cartList[widget.index].qualtity =
                      cartList[widget.index].qualtity! + 1;
                });

                Provider.of<TotalClass>(context, listen: false)
                    .showTotal(cartList[widget.index].price!.toDouble());
              },
              child: const Text(
                "+",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
