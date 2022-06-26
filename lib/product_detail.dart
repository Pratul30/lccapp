import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/products.dart';

class ProductsDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productid = ModalRoute.of(context).settings.arguments as String;
    final product =
        Provider.of<Products>(context, listen: false).findbyid(productid);
    return Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.network(
              product.imageUrl,
              height: 200,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            product.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(product.desc),
          ),
          SizedBox(height: 10),
          Text(
            'Price: ₹ ${product.price.toString()}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ]));
  }
}
