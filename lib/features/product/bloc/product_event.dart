part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductCreateStarted extends ProductEvent {
  final ProductModel product;

  ProductCreateStarted({required this.product});
}

class ProductFetchStarted extends ProductEvent {}

class ProductFilterChanged extends ProductEvent {
  final CategoryModel category;

  ProductFilterChanged(this.category);

  @override
  List<Object> get props => [category];
}
