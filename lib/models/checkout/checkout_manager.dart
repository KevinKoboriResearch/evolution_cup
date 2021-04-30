import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/carts/cart_manager.dart';
import 'package:mewnu/models/categories/category_manager.dart';
import 'package:mewnu/models/products/product.dart';
import 'package:mewnu/models/checkout/credit_card.dart';
import 'package:mewnu/models/orders/order.dart';
import 'package:mewnu/models/products/product.dart';
import 'package:mewnu/services/cielo_payment.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/orders/order.dart';
import 'package:mewnu/models/user/user_model.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/user/user_model.dart';
import 'package:mewnu/models/user/user_manager.dart';

import 'package:mewnu/models/companies/company.dart';

import 'package:mewnu/models/companies/company.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/companies_categories/categories_screen.dart';
// import 'package:mewnu/screens/companies/company_clients/company_clients_screen.dart';
import 'package:mewnu/screens/companies_company_orders/company_orders_screen.dart';
// import 'package:mewnu/screens/user/sign_in/sign_in_screen.dart';
import 'package:mewnu/models/companies/company.dart';
import 'package:mewnu/screens/user_google_sign_in/google_sign_in_screen.dart';
import 'package:mewnu/common/menu_tile.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/companies/company.dart';
import 'package:mewnu/models/categories/category_manager.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/companies_categories/categories_screen.dart';
import 'package:mewnu/screens/companies_edit_company/edit_company_screen.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;
  // CategoryManager productManager;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  Future<void> checkout(
      {
      // @required BuildContext context,
      @required String companyId,
      @required CreditCard creditCard,
      @required Function onStockFail,
      @required Function onSuccess,
      @required Function onPayFail}) async {
    loading = true;

    final orderId = await _getOrderId(companyId);

    String payId;
    try {
      payId = await CieloPayment().authorize(
        creditCard: creditCard,
        price: cartManager.totalPrice,
        orderId: orderId.toString(),
        user: cartManager.user,
      );
      debugPrint('success $payId');
    } catch (e) {
      onPayFail(e);
      loading = false;
      return;
    }

    try {
      await _decrementStock(companyId);
    } catch (e) {
      CieloPayment().cancel(payId);
      onStockFail(e);
      loading = false;
      return;
    }

    try {
      await CieloPayment().capture(payId);
    } catch (e) {
      onPayFail(e);
      loading = false;
      return;
    }

    final order = Order.fromCartManager(cartManager);
    order.orderId = orderId.toString();
    order.payId = payId;

    await order.save(companyId);

    cartManager.clear(companyId);

    onSuccess(order);
    loading = false;
  }

  Future<int> _getOrderId(companyId) async {
    //  final Product productProvider = Provider.of(context, listen: false);
    // final ref = FirebaseFirestore.instance.doc(
    //     'companies/P6JBIDoicIIeVdMxrQQn/orderCounter/QpiZ2YsBzFMX0Lahq1rX');
    final ref = FirebaseFirestore.instance
        .collection('companies')
        .doc(companyId)
        .collection('orderCounter')
        .doc('QpiZ2YsBzFMX0Lahq1rX');
    // final QuerySnapshot query = await FirebaseFirestore.instance
    //     .collection('companies')
    //     .doc(companyId)
    //     .collection('orderCounter')
    //     .get();
    // final ref = query.docs[0];
    try {
      final result =
          await FirebaseFirestore.instance.runTransaction((tx) async {
        final doc = await tx.get(ref);
        final orderId = doc.data()['current'] as int;
        await tx.update(ref, {'current': orderId + 1});
        return {'orderId': orderId};
      });
      return result['orderId'] as int;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Falha ao gerar número do pedido');
    }
  }

// Future<int> _getOrderId(String companyId) async {
//     final ref = FirebaseFirestore.instance.collection('companies/$companyId/orderCounter');///YreyKQxdKXUpeE3aXeed');

//     try {
//       final result = await FirebaseFirestore.instance.runTransaction((tx) async {
//         final QuerySnapshot query = await ref.get();
//         final doc = query.docs.first;
//         // final doc = await tx.get(ref).docs.first;
//         final orderId = doc.data()['current'] as int;
//         await tx.update(doc.reference, {'current': orderId + 1});
//         return {'orderId': orderId};
//       });
//       return result['orderId'] as int;
//     } catch (e){
//       debugPrint(e.toString());
//       return Future.error('Falha ao gerar número do pedido');
//     }
//   }

  Future<void> _decrementStock(String companyId) {
    return FirebaseFirestore.instance.runTransaction((tx) async {
      final List<Product> productsToUpdate = [];
      final List<Product> productsWithoutStock = [];
      for (final cartProduct in cartManager.items) {
        Product product;

        if (productsToUpdate.any((p) => p.id == cartProduct.productId)) {
          product =
              productsToUpdate.firstWhere((p) => p.id == cartProduct.productId);
        } else {
          final doc = await tx.get(FirebaseFirestore.instance.doc(
                  '${cartProduct.categoryReference}/products/${cartProduct.productId}') //'companies/$companyId/categories/BzMmYsfOeFdvAGsJzvn0/products/${cartProduct.productId}')
              );
          product = Product.fromDocument(doc);
        }

        cartProduct.product = product;

        final size = product.findSize(cartProduct.size);
        if (size.stock - cartProduct.quantity < 0) {
          productsWithoutStock.add(product);
        } else {
          size.stock -= cartProduct.quantity;
          productsToUpdate.add(product);
        }
      }

      if (productsWithoutStock.isNotEmpty) {
        return Future.error(
            '${productsWithoutStock.length} produtos sem estoque');
      }

      for (final product in productsToUpdate) {
        tx.update(
            FirebaseFirestore.instance
                .doc('${product.categoryReference}/products/${product.id}'),
            {'sizes': product.exportSizeList()});
      }
    });
  }
}
