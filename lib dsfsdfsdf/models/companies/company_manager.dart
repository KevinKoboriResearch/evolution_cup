import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/companies/company.dart';

class CompanyManager extends ChangeNotifier {
  // CompanyManager() {
  //   loadCompanyCompany();
  // }

  // final FirebaseFirestore FirebaseFirestore.instance = FirebaseFirestore.instance;

  List<Company> companyCompany = [];
  // Company company;
  String _search = '';

  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Company> get filteredCompanies {
    final List<Company> filteredCompanies = [];

    if (search.isEmpty) {
      filteredCompanies.addAll(companyCompany);
    } else {
      filteredCompanies.addAll(companyCompany.where((p) {
        if (p.name.toLowerCase().contains(search.toLowerCase())) {
          return true;
        } else {
          return false;
        }
      }));
    }

    return filteredCompanies;
  }

  // Future<void> loadCurrentCompany(String companyId) async {
  //   // if (name == null) {
  //     final DocumentSnapshot docCompany = await FirebaseFirestore.instance
  //         .collection('companies')
  //         .doc(companyId)
  //         .get();

  //     company = Company.fromDocument(docCompany);

  //     notifyListeners();
  // }

  Future<void> loadCompanies() async {
    final QuerySnapshot snapCategories = await FirebaseFirestore.instance
        // .collection('companies')
        // .doc(companyId)
        .collection('companies')
        // .doc('9.6')
        // .collection('companies')
        .where('deleted', isEqualTo: false)
        .get();

    companyCompany =
        snapCategories.docs.map((d) => Company.fromDocument(d)).toList();

    notifyListeners();
  }

  Company findCategoryById(String id) {
    try {
      return companyCompany.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void update(Company company) {
    companyCompany.removeWhere((p) => p.id == company.id);
    companyCompany.add(company);
    notifyListeners();
  }

  void delete(Company company) {
    company.delete();
    companyCompany.removeWhere((p) => p.id == company.id);
    notifyListeners();
  }
}
