import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jurysoft_task/providers.dart';
import 'package:jurysoft_task/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../consts/cat_list.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Razorpay? _razorPay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _razorPay = Razorpay();

    _razorPay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "SUCCESS PAYMENT: ${response.paymentId}");
    Get.to(const HomeScreen());
    Provider.of<TotalClass>(context).totalAmount = 0.0;
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR HERE: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  openPaymentPortal(double total) async {
    var options = {
      'key': 'rzp_test_rlKcGEOlAZsaLE',
      'amount': total * 100,
      'name': 'Rahul P',
      'description': 'Payment',
      'prefill': {'contact': '9495002318', 'email': 'rahulp2318@gmail.com'},
      'external': {
        'wallets': ['paytm', 'payzap']
      }
    };
    try {
      _razorPay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final double total = Provider.of<TotalClass>(context).totalAmount;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                openPaymentPortal(total);
              },
              child: const Text(
                "Pay now",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cartList.length,
        itemBuilder: (BuildContext ctx, index) {
          return ListTile(
            leading: Image.network(
              cartList[index].image.toString(),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cartList[index].title.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text("x"),
                Text(
                  cartList[index].qualtity.toString(),
                ),
              ],
            ),
            subtitle: Text(
              "Rs ${cartList[index].total.toString()}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'Rs $total',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
