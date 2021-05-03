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
import 'package:mewnu/models/companies/company_manager.dart';
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

import 'package:mewnu/models/admin/client_model.dart';

class AdminOrdersManager extends ChangeNotifier {
  final List<Order> _orders = [];

  ClientModel clientFilter;
  List<Status> statusFilter = [Status.preparing];
  bool adminEnabled;
  StreamSubscription _subscription;

  void updateUserAdmin(BuildContext context, UserManager userManager) {
    adminEnabled = userManager.adminEnabled(context);
    // _orders.clear();

    // _subscription?.cancel();
    // if (adminEnabled) {
    // _listenToOrders(context, company);
    // }
  }

  void updateCompanyAdmin(BuildContext context, Company company) {
    _orders.clear();

    _subscription?.cancel();
    // if (adminEnabled == true) {
    _listenToOrders(context, company);
    // }
  }

  List<Order> get filteredOrders {
    List<Order> output = _orders.reversed.toList();

    if (clientFilter != null) {
      output = output.where((o) => o.userId == clientFilter.id).toList();
    }

    return output.where((o) => statusFilter.contains(o.status)).toList();
  }

  void _listenToOrders(BuildContext context, Company company) {
    // Company companyProvider = Provider.of(context, listen: false);

    _subscription = FirebaseFirestore.instance
        .collection('companies')
        .doc(company.id)
        .collection('orders')
        .snapshots()
        .listen((event) {
      for (final change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(Order.fromDocument(change.doc));
            break;
          case DocumentChangeType.modified:
            final modOrder =
                _orders.firstWhere((o) => o.orderId == change.doc.id);
            modOrder.updateFromDocument(change.doc);
            break;
          case DocumentChangeType.removed:
            debugPrint('Deu problema sério!!!');
            break;
        }
      }
      notifyListeners();
    });
  }

  void setUserFilter(ClientModel client) {
    clientFilter = client;
    notifyListeners();
  }

  void setStatusFilter({Status status, bool enabled}) {
    if (enabled) {
      statusFilter.add(status);
    } else {
      statusFilter.remove(status);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
