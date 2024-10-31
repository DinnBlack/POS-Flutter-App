part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class OrderCreateStarted extends OrderEvent {
  final OrderModel order;

  OrderCreateStarted({required this.order});
}

class AddProductToOrderListStarted extends OrderEvent {
  final ProductModel product;

  AddProductToOrderListStarted(this.product);
}

class RemoveProductFromOrderListStarted extends OrderEvent {
  final ProductModel product;

  RemoveProductFromOrderListStarted(this.product);
}

class ClearOrderProductListStarted extends OrderEvent {}