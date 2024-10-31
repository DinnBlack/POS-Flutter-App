part of 'product_bloc.dart';

abstract class ProductEvent {}

class ProductCreateStarted extends ProductEvent {
  final ProductModel product;

  ProductCreateStarted({required this.product});
}

class ProductFetchStarted extends ProductEvent {
  final CategoryModel category;

  ProductFetchStarted(this.category);
}