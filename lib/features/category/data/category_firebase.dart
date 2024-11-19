import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../store/bloc/store_bloc.dart';
import '../model/category_model.dart';
import '../../store/model/store_model.dart';

class CategoryFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final BuildContext context;

  CategoryFirebase(this.context);

  Future<List<CategoryModel>> fetchCategories() async {
    final User? user = _firebaseAuth.currentUser;
    final StoreModel? store = context.read<StoreBloc>().selectedStore;

    try {
      DatabaseReference categoriesRef =
          _database.ref('users/${user!.uid}/stores/${store!.id}/categories');
      DatabaseEvent event = await categoriesRef.once();

      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> categoriesMap =
            event.snapshot.value as Map<dynamic, dynamic>;

        List<CategoryModel> categories = categoriesMap.entries.map((entry) {
          Map<String, dynamic> categoryData =
              Map<String, dynamic>.from(entry.value);
          return CategoryModel.fromMap(categoryData);
        }).toList();

        return categories;
      } else {
        return [];
      }
    } catch (e) {
      print('Failed to fetch categories: $e');
      throw e;
    }
  }

  Future<void> createCategory(String title) async {
    final User? user = _firebaseAuth.currentUser;
    final StoreModel? store = context.read<StoreBloc>().selectedStore;

    try {
      if (user != null && store != null) {
        DatabaseReference categoriesRef = _database
            .ref('users/${user.uid}/stores/${store.id}/categories')
            .push();

        CategoryModel newCategory = CategoryModel(
          title: title,
          count: 0,
        );

        await categoriesRef.set(newCategory.toMap());

        print('Category created successfully!');
      } else {
        print('User or store is null');
      }
    } catch (e) {
      print('Failed to create category: $e');
      throw e;
    }
  }

}
