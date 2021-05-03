import 'package:flutter/material.dart';
import 'package:mewnu/models/current_product_model.dart';
import 'package:mewnu/app/router/products_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:mewnu/providers/products.dart';
// import 'package:mewnu/providers/product.dart';
// import '../widgets/product_grid.dart';
// import '../widgets/badge.dart';
// import '../widgets/app_drawer.dart';
// import '../providers/cart.dart';
// import '../utils/app_routes.dart';

class MewnuAppState extends ChangeNotifier {

  /////////////////////////////// APP STATE

  double _selectedIndex;

  MewnuAppState() : _selectedIndex = 0;

  double get selectedIndex => _selectedIndex;

  set selectedIndex(double idx) {
    _selectedIndex = idx;
    if (_selectedIndex != 0) {
      selectedProduct = null;
    }
    notifyListeners();
  }

  /////////////////////////////// PRODUCTS STATE

  Product _selectedProduct;

  List<Product> _productsProvider = ProductsState().items;

  Product get selectedProduct => _selectedProduct;

  List<Product> get listProductsProvider => _productsProvider;

  set selectedProduct(Product product) {
    _selectedProduct = product;
    notifyListeners();
  }

  String getSelectedProductById() {
    if (!_productsProvider.contains(_selectedProduct)) return '';
    return _selectedProduct.id;
  }

  void setSelectedUserById(String id) {
    var productIndex = _productsProvider.indexWhere((element) {
      return element.id == id;
    });
    if (productIndex != null) {
      _selectedProduct = _productsProvider[productIndex];
      notifyListeners();
    } else {
      return;
    }
  }

  /////////////////////////////// SHOPS STATE

}
