import 'package:flutter/material.dart';
import 'package:jurysoft_task/models/products_model.dart';

import '../consts/cat_list.dart';
import '../services/api_handler.dart';
import '../widgets/feeds_grid.dart';
import 'cart_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;

  // List<ProductsModel> productsList = [];
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   getProducts();

  //   super.didChangeDependencies();
  // }

  // getProducts() async {
  //   productsList = await APIHAndler.getAllProducts();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    APIHAndler.getAllProducts();
    cartList.clear();
    // Size size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            // elevation: 4,
            title: const Text('Home'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                const SizedBox(
                  height: 18,
                ),
                const SizedBox(
                  height: 18,
                ),
                FutureBuilder<List<ProductsModel>>(
                  future: APIHAndler.getAllProducts(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Ann error occured ${snapshot.error}"),
                      );
                    }
                    return FeedsGridWidget(productsList: snapshot.data!);
                  }),
                )
              ]),
            ),
          ),
        ));
  }
}
