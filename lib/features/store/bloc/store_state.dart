part of 'store_bloc.dart';

@immutable
abstract class StoreState {}

class StoreInitial extends StoreState {}

// Store Create States
class StoreCreateInProgress extends StoreState {}

class StoreCreateSuccess extends StoreState {}

class StoreCreateFailure extends StoreState {
  final String error;

  StoreCreateFailure({required this.error});
}

// Store Fetch States
class StoreFetchInProgress extends StoreState {}

class StoreFetchSuccess extends StoreState {
  final List<StoreModel> stores;

  StoreFetchSuccess({required this.stores});
}

class StoreFetchFailure extends StoreState {
  final String error;

  StoreFetchFailure({required this.error});
}

// Store Select States
class StoreSelectInProgress extends StoreState {}

class StoreSelectSuccess extends StoreState {
  final StoreModel? selectedStore;

  StoreSelectSuccess({this.selectedStore});
}

class StoreSelectFailure extends StoreState {
  final String error;

  StoreSelectFailure({required this.error});
}

// Store Selected State
class StoreSelected extends StoreState {
  final StoreModel selectedStore;

  StoreSelected({required this.selectedStore});
}
