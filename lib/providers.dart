import 'package:flutter/material.dart';
import 'package:jurysoft_task/consts/cat_list.dart';

class TotalClass extends ChangeNotifier {
  double totalAmount = 0.0;

  TotalClass({required this.totalAmount});

  void showTotal(double total) {
    totalAmount += total;
    notifyListeners();
  }

  void removeItem(double price, int count) {
    print(count);

    // ignore: prefer_is_empty
    if (cartList.length == 0) {
      totalAmount = 0.0;
      notifyListeners();
    } else {
      print(price * count);
      totalAmount = totalAmount - (price * count);
      notifyListeners();
    }
  }
}
