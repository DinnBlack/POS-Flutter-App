import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/order_model.dart';
import '../../../models/store_model.dart';
import '../../store/bloc/store_bloc.dart';

class OrderFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final BuildContext context;

  OrderFirebase(this.context);

  Future<void> createOrder(OrderModel order) async {
    final User? user = _firebaseAuth.currentUser;
    final StoreModel? store = context.read<StoreBloc>().selectedStore;

    if (user == null || store == null) {
      throw Exception('User or Store not found');
    }

    try {
      DatabaseReference orderRef = _database.ref('users/${user.uid}/stores/${store.id}/orders').push();
      String orderId = orderRef.key!;

      OrderModel newOrder = order.copyWith(orderId: orderId);

      await orderRef.set(newOrder.toMap());

      print('Order created successfully: ${newOrder.orderId}');
    } catch (e) {
      print('Failed to create order: $e');
      throw e;
    }
  }

  Future<List<OrderModel>> fetchOrders() async {
    final User? user = _firebaseAuth.currentUser;
    final StoreModel? store = context.read<StoreBloc>().selectedStore;

    if (user == null || store == null) {
      throw Exception('User or Store not found');
    }

    try {
      DatabaseReference ordersRef = _database.ref('users/${user.uid}/stores/${store.id}/orders');
      DatabaseEvent event = await ordersRef.once();

      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> ordersMap = event.snapshot.value as Map<dynamic, dynamic>;

        List<OrderModel> orders = ordersMap.entries.map((entry) {
          Map<String, dynamic> orderData = Map<String, dynamic>.from(entry.value);
          return OrderModel.fromMap(orderData);
        }).toList();

        return orders;
      } else {
        return [];
      }
    } catch (e) {
      print('Failed to fetch orders: $e');
      throw e;
    }
  }
}
