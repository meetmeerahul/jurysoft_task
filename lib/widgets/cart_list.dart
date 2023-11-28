import 'package:flutter/material.dart';
import 'package:jurysoft_task/widgets/cart_list_item.dart';

import '../consts/cat_list.dart';


Widget cartItems() {
  return ListView.builder(
      itemCount: cartList.length,
      itemBuilder: (BuildContext context, index) {
        return CartListItem(index: index);
      });
}
