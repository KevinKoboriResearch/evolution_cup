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
import 'package:mewnu/models/admin/admin_orders_manager.dart';
import 'package:mewnu/screens/companies_categories/categories_screen.dart';
import 'package:mewnu/screens/companies_edit_company/edit_company_screen.dart';

class AdminUsersManager extends ChangeNotifier {
  List<UserModel> users = [];

  StreamSubscription _subscription;

  void updateUser(BuildContext context, AdminOrdersManager adminOrdersManager) {
    _subscription?.cancel();
    if (true) {
      _listenToUsers(adminOrdersManager);
    } else {
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers(AdminOrdersManager adminOrdersManager) {
    _subscription = FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((snapshot) {
      users = snapshot.docs.map((d) => UserModel.fromDocument(d)).toList();
      users
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      notifyListeners();
    });
  }

  List<String> get names => users.map((e) => e.name).toList();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
