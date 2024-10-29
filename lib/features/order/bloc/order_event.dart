part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class OrderCreateStarted extends OrderEvent {
  final OrderModel order;

  OrderCreateStarted({required this.order});
}
