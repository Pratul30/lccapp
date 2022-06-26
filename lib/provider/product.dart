import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  @required
  final String id;
  @required
  final String title;
  @required
  final String desc;
  @required
  final int price;
  @required
  final String imageUrl;

  Product({
    this.id,
    this.title,
    this.desc,
    this.price,
    this.imageUrl,
  });
}
