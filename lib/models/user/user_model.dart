import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mewnu/models/checkout/address.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class UserModel {
  UserModel({this.email, this.password, this.name, this.id});

  UserModel.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    name = doc.data()['name'] as String;
    email = doc.data()['email'] as String;
    imageProfile = doc.data()['imageProfile'] as String;
    cpf = doc.data()['cpf'] as String;
    if (doc.data().containsKey('address')) {
      address = Address.fromMap(doc.data()['address'] as Map<String, dynamic>);
    }
    if (doc.data().containsKey('companiesAdmin')) {
      companiesAdmin = doc.data()['companiesAdmin'] as List<dynamic>;
    }
  }

  String id;
  String name;
  String email;
  String imageProfile;
  String cpf;
  String password;

  String confirmPassword;

  bool admin = false;

  Address address;

  List<dynamic> companiesAdmin;

  CollectionReference get cartsReference => FirebaseFirestore.instance.doc('users/$id')
      .collection('carts');

  Future<void> saveData() async {
    await FirebaseFirestore.instance.doc('users/$id').set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      if (imageProfile != null) 'imageProfile': imageProfile,
      if (address != null) 'address': address.toMap(),
      if (companiesAdmin != null) 'companiesAdmin': companiesAdmin,
      if (cpf != null) 'cpf': cpf
    };
  }

  Future<void> uploadImageProfile(File newImageProfile) async {
    final UploadTask task =
        FirebaseStorage.instance.ref().child('users').child(id).child(Uuid().v1()).putFile(newImageProfile);
    final TaskSnapshot snapshot = await task.whenComplete(() => null);
    final String url = await snapshot.ref.getDownloadURL() as String;
    setImageProfile(url);
    // saveData();
  }

  void setImageProfile(String imageProfile) {
    this.imageProfile = imageProfile;
    saveData();
  }

  void setAddress(Address address) {
    this.address = address;
    saveData();
  }

  void setCompaniesAdmin(String companyId) {
    companiesAdmin.add(companyId);
    saveData();
  }

  void setCpf(String cpf) {
    this.cpf = cpf;
    saveData();
  }

  Future<void> saveToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance.doc('users/$id').collection('tokens').doc(token).set({
      'token': token,
      'updatedAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem,
    });
  }

   Future<void> removeToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance.doc('users/$id').collection('tokens').doc(token).delete();
  }
}
