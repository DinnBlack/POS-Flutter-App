part of 'customer_bloc.dart';

@immutable
sealed class CustomerEvent {}

class CustomerCreateStated extends CustomerEvent {
  final CustomerModel customer;

  CustomerCreateStated(this.customer);
}

class CustomerFetchStated extends CustomerEvent {}

class CustomerSearchStated extends CustomerEvent {
  final String query;

  CustomerSearchStated(this.query);
}
