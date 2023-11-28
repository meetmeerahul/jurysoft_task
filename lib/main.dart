import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jurysoft_task/providers.dart';
import 'package:provider/provider.dart';

import 'consts/global_colors.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TotalClass>(
      create: (context) => TotalClass(totalAmount: 0),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shoping cart',
        theme: ThemeData(
          scaffoldBackgroundColor: lightScaffoldColor,
          primaryColor: lightCardColor,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: lightIconsColor,
            ),
            backgroundColor: lightScaffoldColor,
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: lightTextColor,
                fontSize: 22,
                fontWeight: FontWeight.bold),
            elevation: 0,
          ),
          iconTheme: IconThemeData(
            color: lightIconsColor,
          ),

          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.black,
            selectionColor: Colors.blue,
            // selectionHandleColor: Colors.blue,
          ),
          // textTheme: TextTheme()
          // textTheme: Theme.of(context).textTheme.apply(
          //       bodyColor: Colors.black,
          //       displayColor: Colors.black,
          //     ),
          cardColor: lightCardColor,
          brightness: Brightness.light,
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(
                secondary: lightIconsColor,
                brightness: Brightness.light,
              )
              .copyWith(background: lightBackgroundColor),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
