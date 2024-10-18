part of 'product_order_bloc.dart';

@immutable
sealed class ProductOrderState {}

class ProductOrderInitial extends ProductOrderState {}

class ProductOrderAddInProgress extends ProductOrderState {}

class ProductOrderAddSuccess extends ProductOrderState {}

class ProductOrderAddFailure extends ProductOrderState {}
