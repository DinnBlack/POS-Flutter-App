part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class OrderCreateStarted extends OrderEvent {}

class OrderFetchStarted extends OrderEvent {
  final String? status;
  final String? sortBy;

  OrderFetchStarted({this.status, this.sortBy});
}

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

class SetDefaultStated extends OrderEvent {}

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
  final String? orderId;
  final int? newTotalPrice;
  final CustomerModel? newCustomer;
  final DateTime? newOrderTime;
  final String? newStatus;
  final String? newExecutor;
  final String? newPaymentStatus;
  final String? newNote;
  final String? newPaymentMethod;
  final int? newDiscount;
  final int? newShipping;
  final int? newSurcharge;
  final int? newPaidAmount;

  UpdateOrderDetailsStarted({
    this.orderId,
    this.newTotalPrice,
    this.newCustomer,
    this.newOrderTime,
    this.newStatus,
    this.newExecutor,
    this.newPaymentStatus,
    this.newNote,
    this.newPaymentMethod,
    this.newDiscount,
    this.newShipping,
    this.newSurcharge,
    this.newPaidAmount,
  });
}

class SelectCustomerStarted extends OrderEvent {
  final CustomerModel customerSelect;

  SelectCustomerStarted({required this.customerSelect});
}

class PrePaymentStarted extends OrderEvent {
  final String paymentStatus;
  final int paidAmount;
  final String paymentMethod;

  PrePaymentStarted({
    required this.paymentStatus,
    required this.paidAmount,
    required this.paymentMethod,
  });
}
