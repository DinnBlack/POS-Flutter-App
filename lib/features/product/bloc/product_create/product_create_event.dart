part of 'product_create_bloc.dart';

@immutable
sealed class ProductCreateEvent {}

class ProductCreateStarted extends ProductCreateEvent {}