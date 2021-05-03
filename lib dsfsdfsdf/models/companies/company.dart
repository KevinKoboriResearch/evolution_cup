import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/products/item_size.dart';
import 'package:uuid/uuid.dart';
import 'package:mewnu/models/user/user_manager.dart';

class Company extends ChangeNotifier {
  Company(
      {this.id,
      this.name,
      this.description,
      this.images,
      this.autoplay,
      this.type,
      this.whats,
      this.deleted = false}) {
    images = images ?? [];
  }

  Company.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    name = doc['name'] as String;
    whats = doc['whats'] as String;
    description = doc['description'] as String;
    images = List<String>.from(doc.data()['images'] as List<dynamic>);
    autoplay = doc['autoplay'] as bool;
    type = doc['type'] as double;
    deleted = (doc.data()['deleted'] ?? false) as bool;
  }

  Future<void> loadCurrentCompany(String companyId) async {
    // if (name == null) {
    final DocumentSnapshot docCompany = await FirebaseFirestore.instance
        .collection('companies')
        .doc(companyId)
        .get();

    setCompany(Company.fromDocument(docCompany));

    notifyListeners();
  }

  String id;
  String name;
  String whats;
  String description;
  List<String> images;
  bool autoplay;
  double type;
  List<dynamic> newImages;

  bool deleted;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ItemSize _selectedSize;
  ItemSize get selectedSize => _selectedSize;
  set selectedSize(ItemSize value) {
    _selectedSize = value;
    notifyListeners();
  }

  void setCompany(Company company) {
    id = company.id;
    name = company.name;
    whats = company.whats;
    description = company.description;
    images = company.images;
    autoplay = company.autoplay;
    type = company.type;
  }

  Future<void> firestoreAdd(UserManager userManager) async {
    loading = true;
    //.user.setCompaniesAdmin([companyId]);
    final Map<String, dynamic> data = {
      // 'companyId': companyId,
      'name': name,
      'whats': whats != null ? whats : '',
      'description': description,
      'autoplay': autoplay,
      'type': type,
      'deleted': deleted
    };

    if (id == null) {
      final Map<String, dynamic> delivery = {
        'base': 5,
        'km': 0.7,
        'lat': -15.853906638336642,
        'lng': -47.859486883810796,
        'maxkm': 200,
      };
      final Map<String, dynamic> orderCounter = {
        'current': 0,
      };
      final docRef =
          await FirebaseFirestore.instance.collection('companies').add(data);
      await FirebaseFirestore.instance
          .doc(docRef.path)
          .collection('delivery')
          .add(delivery);
      await FirebaseFirestore.instance
          .doc(docRef.path)
          .collection('orderCounter')
          .add(orderCounter);
      // data2['CompanyReference'] = docRef.path;
      // await FirebaseFirestore.instance
      //     .collection('allCategories')
      //     .doc('9.6')
      //     .collection('allCategories')
      //     .doc(docRef.id)
      //     .set(data2);
      userManager.user.setCompaniesAdmin(docRef.id);
      id = docRef.id;
    } else {
      await FirebaseFirestore.instance.doc('companies/$id').update(data);
      // await FirebaseFirestore.instance
      //     .collection('allCategories')
      //     .doc('9.6')
      //     .collection('allCategories')
      //     .doc(id)
      //     .update(data);
    }

    final List<String> updateImages = [];

    for (final newImage in newImages) {
      if (images.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        final UploadTask task = FirebaseStorage.instance
            .ref()
            .child('companies')
            .child(id)
            .child(Uuid().v1())
            .putFile(newImage as File);
        final TaskSnapshot snapshot = await task.whenComplete(() => null);
        final String url = await snapshot.ref.getDownloadURL() as String;
        updateImages.add(url);
      }
    }

    for (final image in images) {
      if (!newImages.contains(image) && image.contains('firebase')) {
        try {
          final ref = await FirebaseStorage.instance.refFromURL(image);
          await ref.delete();
        } catch (e) {
          debugPrint('Falha ao deletar $image');
        }
      }
    }

    await FirebaseFirestore.instance
        .doc('companies/$id')
        .update({'images': updateImages});

    images = updateImages;

    loading = false;
  }

  void delete() {
    FirebaseFirestore.instance.doc('companies/$id').update({'deleted': true});
  }

  Company clone() {
    return Company(
      id: id,
      name: name,
      description: description,
      whats: whats,
      images: List.from(images),
      autoplay: autoplay,
      type: type,
      deleted: deleted,
    );
  }

  @override
  String toString() {
    return 'Company{id: $id, name: $name, description: $description, images: $images, newImages: $newImages, autoplay: $autoplay, type: $type}';
  }
}
