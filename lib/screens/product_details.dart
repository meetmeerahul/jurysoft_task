import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';


import '../consts/global_colors.dart';
import '../models/products_model.dart';
import '../services/api_handler.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductsModel? productModel;

  Future<void> getProductInfo() async {
    productModel = await APIHAndler.getProductsById(id: widget.id);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getProductInfo();
    super.didChangeDependencies();
  }

  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    getProductInfo();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: productModel == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
                    const BackButton(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Text(
                                  productModel!.title.toString(),
                                  textAlign: TextAlign.start,
                                  style: titleStyle,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Rs.',
                                      style: const TextStyle(
                                          fontSize: 25,
                                          color:
                                              Color.fromRGBO(33, 150, 243, 1)),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                productModel!.price.toString(),
                                            style: TextStyle(
                                                color: lightTextColor,
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.4,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return FancyShimmerImage(
                            width: double.infinity,
                            imageUrl: productModel!.images![index].toString(),
                            boxFit: BoxFit.fill,
                          );
                        },

                        autoplay: true,
                        itemCount: 3,
                        pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                            color: Colors.white,
                            activeColor: Colors.red,
                          ),
                        ),
                        // control: const SwiperControl(),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(productModel!.description.toString(),
                              style: titleStyle),
                          const SizedBox(
                            height: 18,
                          ),
                          Text(
                            productModel!.description.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 25),
                          ),
                          const Row(
                            children: [Icon(Icons.plus_one)],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
