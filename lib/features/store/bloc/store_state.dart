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

// Store Select States
class StoreSelectInProgress extends StoreState {}

class StoreSelectSuccess extends StoreState {
 final List<StoreModel> stores;

 StoreSelectSuccess({required this.stores});
}

class StoreSelectFailure extends StoreState {
 final String error;

 StoreSelectFailure({required this.error});
}
