import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:jurysoft_task/models/products_model.dart';
import 'package:jurysoft_task/providers.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';


import '../consts/cat_list.dart';
import '../consts/global_colors.dart';

import '../models/cart_model.dart';
import '../screens/product_details.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  @override
  Widget build(BuildContext context) {
    final ProductsModel productsModelProvider =
        Provider.of<ProductsModel>(context);

    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: ProductDetails(id: productsModelProvider.id.toString()),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                            text: 'Rs ',
                            style: const TextStyle(
                                color: Color.fromRGBO(33, 150, 243, 1)),
                            children: <TextSpan>[
                              TextSpan(
                                  text: productsModelProvider.price.toString(),
                                  style: TextStyle(
                                      color: lightTextColor,
                                      fontWeight: FontWeight.w600)),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  height: size.height * 0.2,
                  width: double.infinity,
                  errorWidget: const Icon(
                    IconlyBold.danger,
                    color: Colors.red,
                    size: 28,
                  ),
                  imageUrl: productsModelProvider.images![0],
                  boxFit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  productsModelProvider.title.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 17,
                    //  fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextButton(
                onPressed: () {
                  if (productsModelProvider.addedToCart == true) {
                    // Find the index of the item in cartList with the same ID
                    int indexToRemove = cartList.indexWhere(
                      (item) => item.id == productsModelProvider.id,
                    );

                    if (indexToRemove != -1) {
                      setState(() {
                        int? qty = cartList[indexToRemove].qualtity;

                        cartList.removeAt(indexToRemove);

                        Provider.of<TotalClass>(context, listen: false)
                            .removeItem(productsModelProvider.price!.toDouble(),
                                qty!); // Remove the item at the found index
                        productsModelProvider.addedToCart = false;

                        itemCount = 0;
                      });
                    }
                  } else {
                    CartModel cart = CartModel(
                        id: productsModelProvider.id,
                        image: productsModelProvider.images![0],
                        price: productsModelProvider.price,
                        qualtity: 1,
                        title: productsModelProvider.title,
                        total: productsModelProvider.price);
                    cartList.add(cart);
                    print(cartList);
                    setState(() {
                      itemCount++;
                      productsModelProvider.addedToCart = true;

                      Provider.of<TotalClass>(context, listen: false)
                          .showTotal(productsModelProvider.price!.toDouble());
                    });
                  }
                  print(cartList.toString());
                },
                child: productsModelProvider.addedToCart == false
                    ? const Text("Add to cart")
                    : const Text("Remove"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
