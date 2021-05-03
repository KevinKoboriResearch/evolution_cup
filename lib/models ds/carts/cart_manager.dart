import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mewnu/models/checkout/address.dart';
import 'package:mewnu/models/carts/cart_product.dart';
import 'package:mewnu/models/companies/company_manager.dart';
import 'package:mewnu/models/products/product.dart';
import 'package:mewnu/models/companies/company.dart';
import 'package:mewnu/models/user/user_model.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/services/geocoding_google.dart';
// import 'package:mewnu/models/companies/company.dart';
// import 'package:mewnu/services/cepaberto_service.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];
  List<DocumentSnapshot> carts = [];
  UserModel user;
  Address address;
  String companyId;
  num productsPrice = 0.0;
  num deliveryPrice;

  num get totalPrice => productsPrice + (deliveryPrice ?? 0);

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String _search = '';

  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<DocumentSnapshot> get filteredCarts {
    final List<DocumentSnapshot> filteredCarts = [];

    if (search.isEmpty) {
      filteredCarts.addAll(carts);
    } else {
      filteredCarts.addAll(
        carts.where(
          (p) {
            String companyName =
                p.data()['companyName'].toLowerCase() as String;
            if (companyName.toLowerCase().contains(search.toLowerCase()) !=
                null) {
              return true;
            } else {
              return false;
            }
            // if (p
            //         .data()['companyName']
            //         .toLowerCase()
            //         .contains(search.toLowerCase()) !=
            //     null) {
            //   return true;
            // } else {
            //   return false;
            // }
          },
        ),
      );
    }

    return filteredCarts;
  }

  void updateUser(UserManager userManager) {
    user = userManager.user;
    // this.companyId = companyId;
    productsPrice = 0.0;
    items.clear();
    removeAddress();

    if (user != null) {
      loadCarts();
      _loadUserAddress();
    }
  }

  Future<void> loadCarts() async {
    final QuerySnapshot cartSnap = await user.cartsReference.get();

    carts = cartSnap.docs;
    carts.map((doc) {
      loadCartItems(doc.id);
    }).toList();
  }

  Future<void> loadCartItems(String companyId) async {
    this.companyId = companyId;
    final QuerySnapshot cartSnap =
        await user.cartsReference.doc('$companyId').collection('cart').get();

    items = cartSnap.docs
        .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated))
        .toList();
  }

  Future<void> _loadUserAddress() async {
    // Future<void> _loadUserAddress(String companyId) async {
    if (user.address != null &&
        await calculateDelivery(
            companyId, user.address.lat, user.address.lng)) {
      address = user.address;
      notifyListeners();
    }
  }

  // void addToCart(Company company, Product product) {
  //   try {
  //     final e = items.firstWhere((p) => p.stackable(product));
  //     e.increment();
  //   } catch (e) {
  //     final cartProduct = CartProduct.fromProduct(product);
  //     cartProduct.addListener(_onItemUpdated);
  //     items.add(cartProduct);

  //     user.cartsReference
  //         .doc('${company.id}')
  //         .set({'companyName' : company.name});

  //     user.cartsReference
  //         .doc('${company.id}')
  //         .collection('cart')
  //         .add(cartProduct.toCartItemMap())
  //         .then((doc) => cartProduct.id = doc.id);
  //     _onItemUpdated();
  //   }
  //   notifyListeners();
  // }

  void addToCart(Company company, Product product) {
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);

      user.cartsReference
          .doc('${company.id}')
          .set({'companyName': company.name});

      user.cartsReference
          .doc('${company.id}')
          .collection('cart')
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.id);
      _onItemUpdated();
    }
    notifyListeners();
  }

  void removeOfCart(String companyId, CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    user.cartsReference
        .doc('$companyId')
        .collection('cart')
        .doc(cartProduct.id)
        .delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void clear(String companyId) {
    user.cartsReference.doc('$companyId').delete();
    // for (final cartProduct in items) {
    //   user.cartsReference
    //       .doc('$companyId')
    //       .collection('cart')
    //       .doc(cartProduct.id)
    //       .delete();
    // }
    items.clear();
    notifyListeners();
  }

  void _onItemUpdated() {
    productsPrice = 0.0;

    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];

      if (cartProduct.quantity == 0) {
        removeOfCart(companyId, cartProduct);
        i--;
        continue;
      }

      productsPrice += cartProduct.totalPrice;

      _updateCartProduct(companyId, cartProduct);
    }

    notifyListeners();
  }

  void _updateCartProduct(String companyId, CartProduct cartProduct) {
    if (cartProduct.id != null)
      user.cartsReference
          .doc('$companyId')
          .collection('cart')
          .doc(cartProduct.id)
          .update(cartProduct.toCartItemMap());
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }

  bool get isAddressValid => address != null && deliveryPrice != null;

  // ADDRESS

  Future<void> getAddress(String cep) async {
    loading = true;

    try {
      final result = await GeocodingGoogleService().getAddressFromCep(cep);

      if (result != null) {
        address = Address(
          zipCode: result.cep,
          street: result.logradouro,
          complement: result.complemento,
          city: result.localidade,
          district: result.bairro,
          state: result.uf,
          lat: result.lat,
          lng: result.lng,
        );
        print(address.toMap().toString());
      }

      loading = false;
    } catch (e) {
      loading = false;
      return Future.error('CEP Inválido');
    }
  }

  Future<void> setAddress(String companyId, Address address) async {
    loading = true;

    this.address = address;

    if (await calculateDelivery(companyId, address.lat, address.lng)) {
      user.setAddress(address);
      loading = false;
    } else {
      loading = false;
      return Future.error('Endereço fora do raio de entrega :(');
    }
  }

  void removeAddress() {
    address = null;
    deliveryPrice = null;
    notifyListeners();
  }

  Future<bool> calculateDelivery(
      String companyId, double lat, double lng) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .doc('companies/$companyId')
        .collection('delivery')
        .get(); //companies/$companyId/

    final DocumentSnapshot doc = querySnapshot.docs.first;
    final latStore = doc.data()['lat'] as double;
    final longStore = doc.data()['lng'] as double;

    final base = doc.data()['base'] as num;
    final km = doc.data()['km'] as num;
    final maxkm = doc.data()['maxkm'] as num;

    double dis = Geolocator.distanceBetween(latStore, longStore, lat, lng);

    dis /= 1000.0;

    debugPrint('Distance $dis');

    if (dis > maxkm) {
      return false;
    }

    deliveryPrice = base + dis * km;
    return true;
  }
}
