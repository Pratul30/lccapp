import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/cart.dart';
import './cart_item.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartproduct = Provider.of<CartProduct>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('My Cart'),
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10),
                  Text('Total Amount',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Spacer(),
                  Chip(
                    label: Text('Rs. ${cartproduct.cartprice}',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.green,
                  ),
                  SizedBox(width: 10),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('Order'),
                  )
                ]),
          ),
          Flexible(
              fit: FlexFit.tight,
              child: ListView.builder(
                itemBuilder: (ctx, i) => CartItem(
                  cartproduct.cartproduct.values.toList()[i].id,
                  cartproduct.cartproduct.keys.toList()[i],
                  cartproduct.cartproduct.values.toList()[i].title,
                  cartproduct.cartproduct.values.toList()[i].price,
                  cartproduct.cartproduct.values.toList()[i].quantity,
                ),
                itemCount: cartproduct.cartcount,
              ))
        ]));
  }
}
