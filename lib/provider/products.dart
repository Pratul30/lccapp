import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/products_overview_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './product.dart';
import '../hamburger_menu.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  Product findbyid(String id) {
    return _items.firstWhere((product) {
      return product.id == id;
    });
  }

  // List<Product> get productsfavorite{
  //   return _items.where((product){return product.isFavorite;}).toList();
  // }

  Future<void> fetch() async {
    final url = Uri.parse(
        'https://buynow-9a917-default-rtdb.firebaseio.com/products.json');
    final response = await http.get(url);
    final responsejson = json.decode(response.body) as List<dynamic>;
    final List<Product> productlist = [];
    if (_items.isEmpty && responsejson.isEmpty) {
      return;
    } else {
      responsejson.forEach((ele) {
        productlist.add(Product(
          id: ele['id'],
          title: ele['title'],
          desc: ele['description'],
          price: ele['price'],
          imageUrl: ele['image_url'],
        ));
      });
      _items = productlist;
      notifyListeners();
    }
  }

  // Future<void> addProduct(Product product) async {
  //   final url = Uri.parse('https://shop-10865-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');
  //   try {
  //   final response = await http.post(url,body:json.encode({
  //     'title': product.title,
  //     'desc': product.desc,
  //     'price' : product.price,
  //     'imageUrl': product.imageUrl,
  //     'isFavorite': product.isFavorite
  //   }));
  //     final newproduct = Product(
  //     title: product.title,
  //     price: product.price,
  //     desc: product.desc,
  //     imageUrl: product.imageUrl,
  //     id: json.decode(response.body)['name'].toString()
  //   );
  //   _items.add(newproduct);
  //   notifyListeners();
  //   }catch(error){
  //     throw error;
  //   }
  // }

  // Future<void> updateProduct(Product product) async {
  //   final url = Uri.parse(
  //       'https://shop-10865-default-rtdb.asia-southeast1.firebasedatabase.app/products/${product.id}.json');
  //   await http.patch(url,
  //       body: json.encode({
  //         'title': product.title,
  //         'desc': product.desc,
  //         'imageUrl': product.imageUrl,
  //         'price': product.price,
  //       }));
  //   final productindex =
  //       _items.indexWhere((tempproduct) => tempproduct.id == product.id);
  //   _items[productindex] = product;
  //   notifyListeners();
  // }

  // void delete(String id) {
  //   final url = Uri.parse(
  //       'https://shop-10865-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json');
  //   final productindex = _items.indexWhere((product) => product.id == id);
  //   var productdata = _items[productindex];
  //   _items.removeAt(productindex);
  //   http.delete(url).then((_) {
  //     productdata = null;
  //   }).catchError((_) {
  //     _items.insert(productindex, productdata);
  //   });
  //   notifyListeners();
  // }
}
