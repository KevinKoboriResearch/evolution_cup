import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/products/product.dart';

class ProductManager extends ChangeNotifier {
  // ProductManager() {
  //   loadCompanyCategoryProducts();
  // }

  List<Product> companyProducts = [];

  String _search = '';

  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if (search.isEmpty) {
      filteredProducts.addAll(companyProducts);
    } else {
      filteredProducts.addAll(companyProducts.where((p) {
        if (p.name.toLowerCase().contains(search.toLowerCase())) {
          return true;
        } else {
          return false;
        }
      }));
    }

    return filteredProducts;
  }

  Future<void> loadCompanyCategoryProducts(String companyIdFrom, String categoryId) async {
    final QuerySnapshot snapProducts = await FirebaseFirestore.instance
        .collection('companies')
        .doc(companyIdFrom)
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .where('deleted', isEqualTo: false)
        .get();

    companyProducts =
        snapProducts.docs.map((d) => Product.fromDocument(d)).toList();

    notifyListeners();
  }

  Product findProductById(String id) {
    try {
      return companyProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void update(Product product) {
    companyProducts.removeWhere((p) => p.id == product.id);
    companyProducts.add(product);
    notifyListeners();
  }

  void delete(
    String companyIdFrom,
    Product product,
    String categoryId,
    double categoryType,
  ) {
    product.delete(
      companyIdFrom,
      product,
      categoryId,
      categoryType,
    );
    companyProducts.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }
}
