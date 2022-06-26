import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/products.dart';
import './provider/cart.dart';
import './cart_screen.dart';
import './product_detail.dart';
import 'products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProduct(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false, //debug tag hide
          title: 'mobile',
          theme: ThemeData(
            primarySwatch: Colors.red,
            accentColor: Colors.blue,
            fontFamily: 'Lato',
          ),
          home: ProductsOverviewScreen(),
          routes: {
            '/product_detail': (context) => ProductsDetail(),
            '/cart_screen': (context) => CartScreen(),
          }),
    );
  }
}
