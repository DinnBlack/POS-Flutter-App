part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class OrderCreateStarted extends OrderEvent {}

class OrderFetchStarted extends OrderEvent {}

class AddProductToOrderListStarted extends OrderEvent {
  final ProductModel product;

  AddProductToOrderListStarted(this.product);
}

class RemoveProductFromOrderListStarted extends OrderEvent {
  final ProductModel product;
  final bool isRemoved;

  RemoveProductFromOrderListStarted(this.product, {this.isRemoved = false});
}

class ClearOrderProductListStarted extends OrderEvent {}

class UpdateProductDetailsStarted extends OrderEvent {
  final ProductModel product;
  final int? newPrice;
  final String? newNote;
  final int? newDiscount;

  UpdateProductDetailsStarted({
    required this.product,
    this.newPrice,
    this.newNote,
    this.newDiscount,
  });
}

class UpdateOrderDetailsStarted extends OrderEvent {
  final int? newTotalPrice;
  final String? newCustomerName;
  final DateTime? newOrderTime;
  final String? newStatus;
  final String? newExecutor;
  final bool? newPaymentStatus;
  final String? newNote;
  final String? newPaymentMethod;

  UpdateOrderDetailsStarted({
    this.newTotalPrice,
    this.newCustomerName,
    this.newOrderTime,
    this.newStatus,
    this.newExecutor,
    this.newPaymentStatus,
    this.newNote,
    this.newPaymentMethod,
  });
}
