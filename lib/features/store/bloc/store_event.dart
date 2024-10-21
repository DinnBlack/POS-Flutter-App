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

class StoreFetchStated extends StoreEvent {}

class StoreSelectStated extends StoreEvent {
  final StoreModel? store;

  StoreSelectStated({this.store});
}
