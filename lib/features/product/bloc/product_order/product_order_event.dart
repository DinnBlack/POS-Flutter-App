part of 'product_order_bloc.dart';

@immutable
sealed class ProductOrderEvent {}

class ProductOrderAddStated extends ProductOrderEvent {}
