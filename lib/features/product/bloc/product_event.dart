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

class AddProductToOrderList extends ProductEvent {
  final ProductModel product;

  AddProductToOrderList(this.product);
}

class RemoveProductFromOrderList extends ProductEvent {
  final ProductModel product;

  RemoveProductFromOrderList(this.product);
}

class ClearOrderProductList extends ProductEvent {}