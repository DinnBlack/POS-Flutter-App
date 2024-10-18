part of 'product_create_bloc.dart';

@immutable
sealed class ProductCreateState {}

class ProductCreateInitial extends ProductCreateState {}

class ProductCreateInProgress extends ProductCreateState {}

class ProductCreateSuccess extends ProductCreateState {}

class ProductCreateFailure extends ProductCreateState {}
