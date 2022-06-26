import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/products.dart';
import './provider/badge.dart';
import './provider/cart.dart';
import './product_item.dart';
import './hamburger_menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var favoritepass = false;
  bool isloading = true;
  List<dynamic> responseData = [];
  var categoryid = '';

  @override
  void initState() {
    Provider.of<Products>(context, listen: false).fetch().then((response) {
      setState(() {
        isloading = false;
      });
    });
    super.initState();
  }

  void didChangeDependencies() {
    getCategories();
    super.didChangeDependencies();
  }

  Future<void> getProductIds() async {
    print(categoryid);
    final url = Uri.parse(
        'https://buynow-9a917-default-rtdb.firebaseio.com/product_categories.json');
    final response = await http.get(url);
    final responsejson = json.decode(response.body) as List<dynamic>;
    final List<dynamic> productIds = [];
    responsejson.forEach((element) {
      if (element['category_id'] == categoryid) {
        productIds.add(element['product_id']);
      }
    });
  }

  Future<void> getCategories() async {
    final url = Uri.parse(
        'https://buynow-9a917-default-rtdb.firebaseio.com/categories.json');
    final response = await http.get(url);
    final responsejson = json.decode(response.body) as List<dynamic>;
    responseData = responsejson;
  }

  @override
  Widget build(BuildContext context) {
    categoryid = ModalRoute.of(context).settings.arguments as String;
    print(categoryid);
    final productsdata = Provider.of<Products>(context);
    final cartdata = Provider.of<CartProduct>(context);
    final products = productsdata.items;

    return Scaffold(
        appBar: AppBar(
          title: Text('Mobiles'),
          actions: [
            Badge(
                child: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/cart_screen');
                    }),
                value: cartdata.cartcount.toString())
          ],
        ),
        drawer: HamburgerMenu(responseData, getProductIds),
        body: isloading
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: EdgeInsets.all(10),
                itemBuilder: (contextBuilder, index) =>
                    ChangeNotifierProvider.value(
                        value: products[index], child: ProductItem()),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 3 / 2,
                )));
  }
}
