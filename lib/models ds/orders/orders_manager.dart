import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/orders/order.dart';
import 'package:mewnu/models/user/user_model.dart';
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

class OrdersManager extends ChangeNotifier {
  UserModel user;

  List<Order> orders = [];

  StreamSubscription _subscription;

  void updateUser(BuildContext context, UserManager userManager) {
    // BuildContext context
    UserModel user = userManager.user;
    //Company company
    final Company companyProvider = Provider.of(context, listen: false);

    this.user = user;
    orders.clear();

    _subscription?.cancel();
    if (user != null) {
      _listenToOrders(companyProvider.id);
    }
  }

  void _listenToOrders(String companyId) {
    _subscription = FirebaseFirestore.instance
        .collection('companies')
        .doc('$companyId')
        .collection('orders')
        .where('user', isEqualTo: user.id)
        .snapshots()
        .listen((event) {
      orders.clear();
      for (final doc in event.docs) {
        orders.add(Order.fromDocument(doc));
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
