import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/categories/category.dart';

class CategoryManager extends ChangeNotifier {
  // CategoryManager() {
  //   loadCompanyCategories();
  // }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Category> companyCategories = [];

  String _search = '';

  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Category> get filteredCategories {
    final List<Category> filteredCategories = [];

    if (search.isEmpty) {
      filteredCategories.addAll(companyCategories);
    } else {
      filteredCategories.addAll(companyCategories.where((p) {
        if (p.name.toLowerCase().contains(search.toLowerCase())) {
          return true;
        } else {
          return false;
        }
      }));
    }

    return filteredCategories;
  }

  Future<void> loadCompanyCategories(String companyId) async {
    final QuerySnapshot snapCategories = await firestore
        .collection('companies')
        .doc(companyId)
        .collection('categories')
        // .doc('9.6')
        // .collection('categories')
        .where('deleted', isEqualTo: false)
        .get();

    companyCategories =
        snapCategories.docs.map((d) => Category.fromDocument(d)).toList();

    notifyListeners();
  }

  Category findCategoryById(String id) {
    try {
      return companyCategories.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void update(Category category) {
    companyCategories.removeWhere((p) => p.id == category.id);
    companyCategories.add(category);
    notifyListeners();
  }

  void delete(Category category) {
    category.delete();
    companyCategories.removeWhere((p) => p.id == category.id);
    notifyListeners();
  }
}
