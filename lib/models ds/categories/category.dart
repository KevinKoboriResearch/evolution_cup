import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/products/item_size.dart';
import 'package:uuid/uuid.dart';

class Category extends ChangeNotifier {
  Category(
      {this.id,
      this.name,
      this.description,
      this.images,
       this.type,
      this.companyId,
      this.companyName,
      this.autoplay,
      this.deleted = false}) {
    images = images ?? [];
  }

  Category.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    name = doc['name'] as String;
      type = doc['type'] as double;
    companyId = doc['companyId'] as String;
    companyName = doc['companyName'] as String;
    description = doc['description'] as String;
    images = List<String>.from(doc.data()['images'] as List<dynamic>);
    autoplay = doc['autoplay'] as bool;
    deleted = (doc.data()['deleted'] ?? false) as bool;
  }

  String id;
  String name;
    double type;
  String companyId;
   String companyName;
  String description;
  List<String> images;
  bool autoplay;
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

  void setCategory(Category category) {
    id = category.id;
    name = category.name;
      type = category.type;
     companyId = category.companyId;
         companyName = category.companyName;
    description = category.description;
    images = category.images;
    autoplay = category.autoplay;
  }

  Future<void> save(String companyId, String companyName ) async {
    loading = true;

    final Map<String, dynamic> data = {
      'companyId': companyId,
       'companyName': companyName,
      'name': name,
         'type': type,
      'description': description,
      'autoplay': autoplay,
      'deleted': deleted
    };

    // final Map<String, dynamic> data2 = {
    //   'name': name,
    //   'description': description,
    //   'sizes': exportSizeList(),
    //   'deleted': deleted,
    //   'categoryReference': '',
    //   'totalHating': 0.0,
    // };

    if (id == null) {
      final docRef = await FirebaseFirestore.instance
          .collection('companies')
          .doc(companyId)
          .collection('categories')
          // .doc('9.6')
          // .collection('categories')
          .add(data);
      // data2['categoryReference'] = docRef.path;
      // await FirebaseFirestore.instance
      //     .collection('allCategories')
      //     .doc('9.6')
      //     .collection('allCategories')
      //     .doc(docRef.id)
      //     .set(data2);
      id = docRef.id;
    } else {
      await FirebaseFirestore.instance.doc('companies/$companyId/categories/$id').update(data);
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
        final UploadTask task =
            FirebaseStorage.instance.ref().child('companies/$companyId/categories').child(id).child(Uuid().v1()).putFile(newImage as File);
        final TaskSnapshot snapshot = await task.whenComplete(() => null);
        final String url = await snapshot.ref.getDownloadURL();
        updateImages.add(url);
      }
    }

    for (final image in images) {
      if (!newImages.contains(image) && image.contains('firebase')) {
        try {
          final ref = FirebaseStorage.instance.refFromURL(image);
          await ref.delete();
        } catch (e) {
          debugPrint('Falha ao deletar $image');
        }
      }
    }

    await FirebaseFirestore.instance.doc('companies/$companyId/categories/$id').update({'images': updateImages});

    images = updateImages;

    loading = false;
  }

  void delete() {
    FirebaseFirestore.instance.doc('companies/$companyId/categories/$id').update({'deleted': true});
    FirebaseFirestore.instance
        .collection('allCategories')
        .doc('$type')
        .collection('allProducts')
        .doc(id)
        .update({'deleted': true});
  }

  Category clone() {
    return Category(
      id: id,
      name: name,
      companyId: companyId,
       companyName: companyName,
      description: description,
            type: type,
      images: List.from(images),
      autoplay: autoplay,
      deleted: deleted,
    );
  }

  @override
  String toString() {
    return 'Category{id: $id, companyId: $companyId, companyName: $companyName, name: $name, description: $description, images: $images, newImages: $newImages, autoplay: $autoplay}';
  }
}
