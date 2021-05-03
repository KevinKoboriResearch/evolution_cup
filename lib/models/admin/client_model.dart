import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mewnu/models/checkout/address.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class ClientModel {
  ClientModel({this.email, this.name, this.code, this.id});

  ClientModel.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    name = doc.data()['name'] as String;
    code = doc.data()['code'] as String;
    email = doc.data()['email'] as String;
  }

  String id;
  String name;
  String code;
  String email;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'email': email,
    };
  }
}
