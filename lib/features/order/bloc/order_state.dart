part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

class OrderInitial extends OrderState {}

// Add Order State
class OrderCreateInProgress extends OrderState {}

class OrderCreateSuccess extends OrderState {}

class OrderCreateFailure extends OrderState {
  final String error;

  OrderCreateFailure({this.error = 'Failed to create order.'});
}
