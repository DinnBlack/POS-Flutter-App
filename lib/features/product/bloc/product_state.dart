part of 'product_bloc.dart';  // Correct file

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

// Add Product State
class ProductCreateInProgress extends ProductState {}

class ProductCreateSuccess extends ProductState {}

class ProductCreateFailure extends ProductState {
  final String error;

  ProductCreateFailure({this.error = 'Failed to create product.'});
}

// Fetch Product State
class ProductFetchInProgress extends ProductState {}

class ProductFetchSuccess extends ProductState {
  final List<ProductModel> products;

  ProductFetchSuccess(this.products);
}

class ProductFetchFailure extends ProductState {
  final String error;

  ProductFetchFailure({this.error = 'Failed to fetch products.'});
}
