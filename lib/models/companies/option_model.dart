import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Option {
  String svg;
  String title;
   // List<Item> items;
  List<Map<String, dynamic>> items;
  Option({this.svg, this.title, this.items});
}

final options = [
  Option(
    svg: 'assets/mewnu/svgs/category_1.svg',
    title: 'Categoria',
    items: [
      {
        'title': 'Restaurante',
        'value': 0.1,
      },
      {
        'title': 'Produtos',
        'value': 0.2,
      },
      {
        'title': 'Serviços',
        'value': 0.3,
      },
    ],
  ),
];
