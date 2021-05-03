import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/admin/client_model.dart';
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
import 'package:mewnu/models/admin/admin_orders_manager.dart';
import 'package:mewnu/models/orders/order.dart';
import 'package:mewnu/screens/companies_categories/categories_screen.dart';
import 'package:mewnu/screens/companies_edit_company/edit_company_screen.dart';

class AdminClientsManager extends ChangeNotifier {
  List<ClientModel> clients = [];
  // List<Map<String, dynamic>> clients = [];

  // StreamSubscription _subscription;
  var _subscription;

  void updateUser(BuildContext context, AdminOrdersManager adminOrdersManager) {
    // _subscription?.cancel();
    _subscription = [];
    if (true) {
      _listenToUsers(adminOrdersManager);
    } else {
      clients.clear();
      notifyListeners();
    }
  }

  void _listenToUsers(AdminOrdersManager adminOrdersManager) {
    // var newList;
    final List<Order> newList = adminOrdersManager.filteredOrders.toSet().toList();
    _subscription = newList.map((order) {
      ClientModel client;
      client.name = order.userName;
      client.code = order.userCode;
      client.id = order.userId;
      client.email = order.userEmail;
      clients.add(client);

      clients.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      // final newList = [];
      // /ClientModel.fromDocument(order)).toList();
      // clients = //ClientModel.fromDocument()).toList();//order.//.map((d) => ClientModel.fromDocument(d)).toList();
      // clients
      //     .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      notifyListeners();
    });
    // _subscription = FirebaseFirestore.instance
    //     .collection('users')
    //     .snapshots()
    //     .listen((snapshot) {
    //   clients = snapshot.docs.map((d) => ClientModel.fromDocument(d)).toList();
    //   clients
    //       .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    //   notifyListeners();
    // });
  }

  List<String> get names => clients.map((e) => e.name).toList();

  @override
  void dispose() {
    // _subscription?.cancel();
      _subscription = [];
    super.dispose();
  }
}
