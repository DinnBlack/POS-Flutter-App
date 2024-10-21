import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/store/bloc/store_bloc.dart';
import '../../models/product_model.dart';
import '../../models/store_model.dart';

class ProductFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final BuildContext context;

  ProductFirebase(this.context);

  Future<void> addProduct(ProductModel product) async {
    final User? user = _firebaseAuth.currentUser;
    final StoreModel? store = context.read<StoreBloc>().selectedStore;

    try {
      List<String> imageUrls = [];
      if (product.image != null) {
        DatabaseReference productRef = _database
            .ref('users/${user!.uid}/stores/${store!.id}/products')
            .push();
        String productId = productRef.key!;

        for (var imagePath in product.image!) {
          File imageFile = File(imagePath);
          String fileName = imageFile.uri.pathSegments.last;

          Reference storageRef =
              _storage.ref('${user.uid}/${store.id}/$productId/$fileName');
          UploadTask uploadTask = storageRef.putFile(imageFile);

          TaskSnapshot snapshot = await uploadTask;
          String downloadUrl = await snapshot.ref.getDownloadURL();
          imageUrls.add(downloadUrl);
        }

        await productRef.set(product.copyWith(image: imageUrls).toMap());
      } else {
        DatabaseReference productRef = _database
            .ref('users/${user!.uid}/stores/${store!.id}/products')
            .push();
        await productRef.set(product.copyWith(image: []).toMap());
      }

      print('Product added successfully: ${product.title}');
    } catch (e) {
      print('Failed to add product: $e');
      throw e;
    }
  }

  Future<List<ProductModel>> fetchProducts() async {
    final User? user = _firebaseAuth.currentUser;
    final StoreModel? store = context.read<StoreBloc>().selectedStore;

    try {
      DatabaseReference productsRef =
          _database.ref('users/${user!.uid}/stores/${store!.id}/products');
      DatabaseEvent event = await productsRef.once();

      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> productsMap =
            event.snapshot.value as Map<dynamic, dynamic>;

        List<ProductModel> products = productsMap.entries.map((entry) {
          Map<String, dynamic> productData =
              Map<String, dynamic>.from(entry.value);
          return ProductModel.fromMap(productData);
        }).toList();

        return products;
      } else {
        return [];
      }
    } catch (e) {
      print('Failed to fetch products: $e');
      throw e;
    }
  }
}
