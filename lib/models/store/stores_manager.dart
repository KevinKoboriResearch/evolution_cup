import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/store/store.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/companies/company.dart';
class StoresManager extends ChangeNotifier {
  StoresManager(){
    // _loadStoreList();
    _startTimer();
  }

  List<Store> stores = [];

  Timer _timer;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadStoreList(String companyId) async {
    final snapshot = await firestore.collection('companies').doc('$companyId').collection('stores').get();

    stores = snapshot.docs.map((e) => Store.fromDocument(e)).toList();

    notifyListeners();
  }

  void _startTimer(){
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkOpening();
    });
  }

  void _checkOpening(){
    for(final store in stores)
      store.updateStatus();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}