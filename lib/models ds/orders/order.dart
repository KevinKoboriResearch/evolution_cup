import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/checkout/address.dart';
import 'package:mewnu/models/carts/cart_manager.dart';
import 'package:mewnu/models/carts/cart_product.dart';
import 'package:mewnu/services/cielo_payment.dart';

import 'package:mewnu/models/admin/client_model.dart';
enum Status { canceled, preparing, transporting, delivered }

class Order {
  Order.fromCartManager(CartManager cartManager) {
    // ClientModel.fromDocument(d)).toList();
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    userCode = cartManager.user.code;
    userName = cartManager.user.name;
    userEmail = cartManager.user.email;
    companyId = cartManager.companyId;
    address = cartManager.address;
    status = Status.preparing;
  }

  Order.fromDocument(DocumentSnapshot doc) {
    orderId = doc.id;

    items = (doc.data()['items'] as List<dynamic>).map((e) {
      return CartProduct.fromMap(e as Map<String, dynamic>);
    }).toList();

    price = doc.data()['price'] as num;
    userId = doc.data()['userId'] as String;
    userName = doc.data()['userName'] as String;
    userEmail = doc.data()['userEmail'] as String;

    userCode = doc.data()['userCode'] as String;
    address = Address.fromMap(doc.data()['address'] as Map<String, dynamic>);
    date = doc.data()['date'] as Timestamp;

    status = Status.values[doc.data()['status'] as int];

    payId = doc.data()['payId'] as String;
  }

  void updateFromDocument(DocumentSnapshot doc) {
    status = Status.values[doc.data()['status'] as int];
  }

  Future<void> save(String companyId) async {
    FirebaseFirestore.instance
        .collection('companies')
        .doc('$companyId')
        .collection('orders')
        .doc(orderId)
        .set({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'userCode': userCode,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'address': address.toMap(),
      'status': status.index,
      'date': Timestamp.now(),
      'payId': payId,
    });
  }

  Function() get back {
    return status.index >= Status.transporting.index
        ? () {
            status = Status.values[status.index - 1];
            FirebaseFirestore.instance
                .collection('companies')
                .doc('$companyId')
                .collection('orders')
                .doc(orderId)
                .update({'status': status.index});
          }
        : null;
  }

  Function() get advance {
    return status.index <= Status.transporting.index
        ? () {
            status = Status.values[status.index + 1];
            FirebaseFirestore.instance
                .collection('companies')
                .doc('$companyId')
                .collection('orders')
                .doc(orderId)
                .update({'status': status.index});
          }
        : null;
  }

  Future<void> cancel(String companyId) async {
    // try {
    //   await CieloPayment().cancel(payId);

    //   status = Status.canceled;
    //   FirebaseFirestore.instance.collection('companies').doc('$companyId').collection('orders').doc(orderId).update({'status': status.index});
    // } catch (e){
    //   debugPrint('Erro ao cancelar');
    //   return Future.error('Falha ao cancelar');
    // }
  }

  String orderId;
  String payId;
  String companyId;
  List<CartProduct> items;
  num price;

  String userId;
  String userName;
  String userEmail;
  String userCode;
  Address address;
  Status status;
  Timestamp date;

  String get formattedId => '#${orderId.padLeft(6, '0')}';

  String get statusText => getStatusText(status);

  static String getStatusText(Status status) {
    switch (status) {
      case Status.canceled:
        return 'Cancelado';
      case Status.preparing:
        return 'Em preparação';
      case Status.transporting:
        return 'Em transporte';
      case Status.delivered:
        return 'Entregue';
      default:
        return '';
    }
  }

  @override
  String toString() {
    return 'Order{orderId: $orderId, items: $items, price: $price, userId: $userId, userCode: $userCode, userName: $userName, userEmail: $userEmail, address: $address, date: $date}';
  }
}
