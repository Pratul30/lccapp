import 'package:flutter/material.dart';

class HamburgerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      AppBar(
        title: Text('BuyNow'),
        automaticallyImplyLeading: false,
      ),
      Divider(),
      ListTile(
          leading: Icon(Icons.shop),
          title: Text('Mobiles'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
      Divider(),
    ]));
  }
}
