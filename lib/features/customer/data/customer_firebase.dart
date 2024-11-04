import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/customer_model.dart';
import '../../../models/store_model.dart';
import '../../store/bloc/store_bloc.dart';

class CustomerFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final BuildContext context;

  CustomerFirebase(this.context);

  Future<void> createCustomer(CustomerModel customer) async {
    final User? user = _firebaseAuth.currentUser;
    final StoreModel? store = context.read<StoreBloc>().selectedStore;

    if (user == null || store == null) {
      throw Exception('User or Store not found');
    }

    try {
      DatabaseReference customerRef = _database
          .ref('users/${user.uid}/stores/${store.id}/customers')
          .child(customer.phoneNumber.toString());
      await customerRef.set(customer.toMap());

      print('Customer created successfully: ${customer.name}');
    } catch (e) {
      print('Failed to create customer: $e');
      throw e;
    }
  }

  Future<List<CustomerModel>> fetchCustomers() async {
    final User? user = _firebaseAuth.currentUser;
    final StoreModel? store = context.read<StoreBloc>().selectedStore;

    if (user == null || store == null) {
      throw Exception('User or Store not found');
    }

    try {
      DatabaseReference customersRef =
      _database.ref('users/${user.uid}/stores/${store.id}/customers');

      final snapshot = await customersRef.get();

      if (snapshot.exists) {
        List<CustomerModel> customers = [];
        Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value as Map);

        data.forEach((key, value) {
          customers.add(CustomerModel.fromMap(Map<String, dynamic>.from(value)));
        });

        return customers;
      } else {
        return [];
      }
    } catch (e) {
      print('Failed to fetch customers: $e');
      throw e;
    }
  }
}
