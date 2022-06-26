import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HamburgerMenu extends StatelessWidget {
  List<dynamic> responsejson;
  Function product;

  HamburgerMenu(this.responsejson, this.product);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      AppBar(
        title: Text('BuyNow'),
        automaticallyImplyLeading: false,
      ),
      Divider(),
      ...responsejson.map(
        (ele) {
          return ListTile(
            leading: Icon(Icons.smartphone),
            title: Text(ele['name']),
            onTap: () {
              print(ele);
              Navigator.pushNamed(context, '/', arguments: ele['id']);
              product();
            },
          );
        },
      )
    ]));
  }
}
