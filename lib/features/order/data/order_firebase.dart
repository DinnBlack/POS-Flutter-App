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
      final now = DateTime.now();
      final datePart =
          '${now.day.toString().padLeft(2, '0')}${now.month.toString().padLeft(2, '0')}${now.year.toString().substring(2)}';

      int orderCount =
          await _getCurrentOrderCount(user.uid, store.id, datePart);

      orderCount++;

      final String orderId =
          '$datePart${orderCount.toString().padLeft(4, '0')}';

      OrderModel newOrder = order.copyWith(orderId: orderId);

      DatabaseReference orderRef = _database
          .ref('users/${user.uid}/stores/${store.id}/orders')
          .child(orderId);
      await orderRef.set(newOrder.toMap());

      await _updateOrderCount(user.uid, store.id, datePart, orderCount);

      print('Order created successfully: ${newOrder.orderId}');
    } catch (e) {
      print('Failed to create order: $e');
      throw e;
    }
  }

  Future<int> _getCurrentOrderCount(
      String userId, String storeId, String datePart) async {
    try {
      DatabaseReference orderCountRef =
          _database.ref('users/$userId/stores/$storeId/orderCount/$datePart');
      DatabaseEvent event = await orderCountRef.once();

      if (event.snapshot.value != null) {
        return (event.snapshot.value as int);
      } else {
        return 0;
      }
    } catch (e) {
      print('Failed to fetch order count: $e');
      return 0;
    }
  }

  Future<void> _updateOrderCount(
      String userId, String storeId, String datePart, int newCount) async {
    try {
      DatabaseReference orderCountRef =
          _database.ref('users/$userId/stores/$storeId/orderCount/$datePart');
      await orderCountRef.set(newCount);
    } catch (e) {
      print('Failed to update order count: $e');
    }
  }

  Future<List<OrderModel>> fetchOrders() async {
    final User? user = _firebaseAuth.currentUser;
    final StoreModel? store = context.read<StoreBloc>().selectedStore;

    if (user == null || store == null) {
      print('User or Store is not available');
      return [];
    }

    try {
      DatabaseReference ordersRef =
          _database.ref('users/${user.uid}/stores/${store.id}/orders');
      DatabaseEvent event = await ordersRef.once();

      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> ordersMap =
            event.snapshot.value as Map<dynamic, dynamic>;

        List<OrderModel> orders = ordersMap.entries
            .map((entry) {
              if (entry.value is Map) {
                Map<String, dynamic> orderData = Map<String, dynamic>.from(
                    entry.value as Map<dynamic, dynamic>);
                return OrderModel.fromMap(orderData);
              } else {
                print(
                    'Invalid order data for entry: ${entry.key} -> ${entry.value}');
                return null;
              }
            })
            .whereType<OrderModel>()
            .toList();

        return orders;
      } else {
        print('No orders found for this user/store');
        return [];
      }
    } catch (e) {
      print('Failed to fetch orders: $e');
      throw Exception('Failed to fetch orders: $e');
    }
  }

  Future<void> updateOrder(String orderId, Map<String, dynamic> updates) async {
    final User? user = _firebaseAuth.currentUser;
    final StoreModel? store = context.read<StoreBloc>().selectedStore;

    // Validate that the user and store are not null
    if (user == null) {
      throw Exception('User not found');
    }

    if (store == null) {
      throw Exception('Store not found');
    }

    try {
      // Create a reference to the order in the database
      DatabaseReference orderRef = _database
          .ref('users/${user.uid}/stores/${store.id}/orders')
          .child(orderId);

      // Update the order with the provided updates
      await orderRef.update(updates);
      print('Order updated successfully: $orderId');
    } catch (e) {
      // Log the error and throw it for further handling
      print('Failed to update order: $e');
      throw Exception('Failed to update order: $e');
    }
  }

  Future<OrderModel?> fetchOrderById(String orderId) async {
    final User? user = _firebaseAuth.currentUser;
    final StoreModel? store = context.read<StoreBloc>().selectedStore;

    if (user == null || store == null) {
      print('User or Store is not available');
      return null;
    }

    try {
      DatabaseReference orderRef =
          _database.ref('users/${user.uid}/stores/${store.id}/orders/$orderId');
      DatabaseEvent event = await orderRef.once();

      if (event.snapshot.value != null) {
        Map<String, dynamic> orderData = Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>);
        return OrderModel.fromMap(orderData); // Convert Map to OrderModel
      } else {
        print('Order not found');
        return null;
      }
    } catch (e) {
      print('Failed to fetch order by ID: $e');
      throw Exception('Failed to fetch order by ID: $e');
    }
  }
}
