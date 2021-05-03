import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/products/item_size.dart';
import 'package:mewnu/models/products/product.dart';

class CartProduct extends ChangeNotifier {
  CartProduct.fromProduct(this._product) {
    productId = product.id;
    categoryReference = product.categoryReference;
    quantity = 1;
    size = product.selectedSize.name;
  }

  CartProduct.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    productId = doc.data()['pid'] as String;
    categoryReference = doc.data()['categoryReference'] as String;
    quantity = doc.data()['quantity'] as int;
    size = doc.data()['size'] as String;

    FirebaseFirestore.instance
        .doc('$categoryReference/products/$productId')
        .get()
        .then((doc) {
      product = Product.fromDocument(doc);
    });
  }

  CartProduct.fromMap(Map<String, dynamic> map) {
    productId = map['pid'] as String;
    categoryReference = map['categoryReference'] as String;
    quantity = map['quantity'] as int;
    size = map['size'] as String;
    fixedPrice = map['fixedPrice'] as num;

    FirebaseFirestore.instance
        .doc('$categoryReference/products/$productId')
        .get()
        .then((doc) {
      product = Product.fromDocument(doc);
    });
  }

  String id;

  String productId;
  String categoryReference;
  int quantity;
  String size;

  num fixedPrice;

  Product _product;

  Product get product => _product;
  set product(Product value) {
    _product = value;
    notifyListeners();
  }

  ItemSize get itemSize {
    if (product == null) return null;
    return product.findSize(size);
  }

  num get unitPrice {
    if (product == null) return 0;
    return itemSize?.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity;

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'categoryReference': categoryReference,
      'quantity': quantity,
      'size': size,
    };
  }

  Map<String, dynamic> toOrderItemMap() {
    return {
      'pid': productId,
      'categoryReference': categoryReference,
      'quantity': quantity,
      'size': size,
      'fixedPrice': fixedPrice ?? unitPrice,
    };
  }

  bool stackable(Product product) {
    return product.id == productId && product.selectedSize.name == size;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }

  bool get hasStock {
    if (product != null && product.deleted) return false;

    final size = itemSize;
    if (size == null) return false;
    return size.stock >= quantity;
  }
}
