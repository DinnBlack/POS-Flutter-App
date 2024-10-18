part of 'store_bloc.dart';

@immutable
abstract class StoreEvent {}

class StoreCreateStated extends StoreEvent {
  final String storeName;
  final String businessType;

  StoreCreateStated({
    required this.storeName,
    required this.businessType,
  });
}

class StoreSelectStated extends StoreEvent {}
