import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/models/products/item_size.dart';
import 'package:uuid/uuid.dart';

class Product extends ChangeNotifier {
  Product(
      {this.id,
      this.companyId,
      this.categoryId,
      this.categoryType,
      this.categoryTitle,
      this.categoryReference,
      this.name,
      this.description,
      this.images,
      this.sizes,
      this.deleted = false}) {
    images = images ?? [];
    sizes = sizes ?? [];
  }

  Product.fromDocument(DocumentSnapshot document) {
    id = document.id;
    companyId = document['companyId'] as String;
    categoryId = document['categoryId'] as String;
    categoryType = document['categoryType'] as double;
    categoryTitle = document['categoryTitle'] as String;
    categoryReference = document['categoryReference'] as String;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.data()['images']
        as List<dynamic>); //document.data()['images'] != null
    deleted = (document.data()['deleted'] ?? false) as bool;
    sizes = (document.data()['sizes'] as List<dynamic> ?? [])
        .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
        .toList();
  }

  String id;
  String companyId;
  String categoryId;
  double categoryType;
  String categoryTitle;
  String categoryReference;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;

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

  int get totalStock {
    int stock = 0;
    for (final size in sizes) {
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0 && !deleted;
  }

  num get basePrice {
    num lowest = double.infinity;
    for (final size in sizes) {
      if (size.price < lowest) lowest = size.price;
    }
    return lowest;
  }

  ItemSize findSize(String name) {
    try {
      return sizes.firstWhere((s) => s.name == name);
    } catch (e) {
      return null;
    }
  }

  List<Map<String, dynamic>> exportSizeList() {
    return sizes.map((size) => size.toMap()).toList();
  }

  Future<void> save(String companyIdFrom, double categoryType, String categoryId,
      String categoryTitle) async {
    loading = true;

    final Map<String, dynamic> data = {
      'companyId': companyIdFrom,
      'categoryId': categoryId,
      'categoryType': categoryType,
      'categoryTitle': categoryTitle,
      'categoryReference': 'companies/$companyIdFrom/categories/$categoryId',
      'name': name,
      'description': description,
      'sizes': exportSizeList(),
      'deleted': deleted
    };

    final Map<String, dynamic> data2 = {
      'companyId': companyIdFrom,
      'categoryId': categoryId,
      'categoryType': categoryType,
      'categoryTitle': categoryTitle,
      'categoryReference':  'companies/$companyIdFrom/categories/$categoryId',
      'name': name,
      'description': description,
      'sizes': exportSizeList(),
      'deleted': deleted,
      'productReference': '',
      'totalHating': 0.0,
    };

    if (id == null) {
      final docRef = await FirebaseFirestore.instance
          .collection('companies')
          .doc(companyIdFrom)
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .add(data);
      data2['productReference'] = docRef.path;
      await FirebaseFirestore.instance
          .collection('allCategories')
          .doc(categoryType.toString())
          .collection('allProducts')
          .doc(docRef.id)
          .set(data2);
      id = docRef.id;
    } else {
      await FirebaseFirestore.instance
          .doc('companies/$companyIdFrom/categories/$categoryId/products/$id')
          .update(data);
      await FirebaseFirestore.instance
          .collection('allCategories')
          .doc(categoryType.toString())
          .collection('allProducts')
          .doc(id)
          .update(data);
    }

    final List<String> updateImages = [];

    for (final newImage in newImages) {
      if (images.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        final UploadTask task = FirebaseStorage.instance
            .ref()
            .child('companies/$companyIdFrom/categories/$categoryId/products')
            .child(id)
            .child(Uuid().v1())
            .putFile(newImage as File);
        final TaskSnapshot snapshot = await task.whenComplete(() => null);
        final String url = await snapshot.ref.getDownloadURL();
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
        .doc('companies/$companyIdFrom/categories/$categoryId/products/$id')
        .update({'images': updateImages});

    images = updateImages;

    loading = false;
  }

  void delete(String companyIdFrom, Product product, String categoryId, double categoryType) {
    FirebaseFirestore.instance
        .doc('companies/$companyIdFrom/categories/$categoryId/products/$id')
        .update({'deleted': true});
    FirebaseFirestore.instance
        .collection('allCategories')
        .doc(product.categoryType.toString())//categoryType.toString())
        .collection('allProducts')
        .doc(product.id)//id)
        .update({'deleted': true});
  }

  Product clone() {
    return Product(
      id: id,
      companyId: companyId,
      categoryId: categoryId,
      categoryType: categoryType,
      categoryTitle: categoryTitle,
      categoryReference: categoryReference,
      name: name,
      description: description,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),
      deleted: deleted,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, companyId: $companyId, categoryId: $categoryId, categoryType: $categoryType, categoryTitle: $categoryTitle, ref: $categoryReference, name: $name, description: $description, images: $images, sizes: $sizes, newImages: $newImages}';
  }
}
