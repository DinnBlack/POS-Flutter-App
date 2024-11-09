part of 'customer_bloc.dart';

@immutable
sealed class CustomerState {}

final class CustomerInitial extends CustomerState {}

class CustomerCreateInProgress extends CustomerState {}

class CustomerCreateSuccess extends CustomerState {
  final String message;
  CustomerCreateSuccess({this.message = 'Customer created successfully.'});
}

class CustomerCreateFailed extends CustomerState {
  final String error;
  CustomerCreateFailed({this.error = 'Failed to create customer.'});
}

class CustomerFetchInProgress extends CustomerState {}

class CustomerFetchSuccess extends CustomerState {
  final List<CustomerModel> customers;

  CustomerFetchSuccess(this.customers);
}

class CustomerFetchFailed extends CustomerState {
  final String error;
  CustomerFetchFailed({this.error = 'Failed to fetch customers.'});
}

class CustomerSearchSuccess extends CustomerState {
  final List<CustomerModel> searchResults;

  CustomerSearchSuccess({required this.searchResults});
}

class CustomerSearchFailed extends CustomerState {
  final String error;

  CustomerSearchFailed({required this.error});
}