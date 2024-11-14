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

class OrderProductListUpdated extends OrderState {
  final List<ProductModel> orderProductList;

  OrderProductListUpdated(this.orderProductList);
}

class SetDefaultState extends OrderState {
  final List<ProductModel> orderProductList;
  final OrderModel currentOrder;

  SetDefaultState(this.orderProductList, this.currentOrder);
}

class OrderUpdated extends OrderState {
  final OrderModel updatedOrder;

  OrderUpdated(this.updatedOrder);
}

class OrderFetchInProgress extends OrderState {}

class OrderFetchSuccess extends OrderState {
  final List<OrderModel> orders;

  OrderFetchSuccess({required this.orders});

  @override
  List<Object?> get props => [orders];
}

class OrderFetchFailure extends OrderState {
  final String error;

  OrderFetchFailure({this.error = 'Failed to fetch orders.'});
}

class OrderUpdateFailure extends OrderState {
  // Added to handle failure case
  final String error;

  OrderUpdateFailure({this.error = 'Failed to update order.'});
}
