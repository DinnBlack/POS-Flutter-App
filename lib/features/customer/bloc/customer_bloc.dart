import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_app/features/customer/data/customer_firebase.dart';

import '../../../models/customer_model.dart';

part 'customer_event.dart';

part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerFirebase _customerFirebase;

  CustomerBloc(this._customerFirebase) : super(CustomerInitial()) {
    on<CustomerCreateStated>(_customerCreate);
    on<CustomerFetchStated>(_customerFetch);
    on<CustomerSearchStated>(_customerSearch);
  }

  Future<void> _customerCreate(
      CustomerCreateStated event, Emitter<CustomerState> emit) async {
    emit(CustomerCreateInProgress());
    try {
      await _customerFirebase.createCustomer(event.customer);
      emit(CustomerCreateSuccess());
      add(CustomerFetchStated());
    } catch (error) {
      if (error
          .toString()
          .contains('Customer with this phone number already exists')) {
        emit(CustomerCreateFailed(error: 'Số điện thoại đã tồn tại'));
      } else {
        emit(CustomerCreateFailed(error: error.toString()));
      }
      print('Customer creation failed: $error');
    }
  }

  Future<void> _customerFetch(
      CustomerFetchStated event, Emitter<CustomerState> emit) async {
    emit(CustomerFetchInProgress());
    try {
      final customers = await _customerFirebase.fetchCustomers();
      emit(CustomerFetchSuccess(customers));
    } catch (error) {
      emit(CustomerFetchFailed(error: error.toString()));
      print('Customer fetching failed: $error');
    }
  }

  Future<void> _customerSearch(
      CustomerSearchStated event, Emitter<CustomerState> emit) async {
    try {
      if (event.query.isEmpty) {
        emit(CustomerSearchSuccess(
            searchResults: [CustomerModel(name: 'Khách lẻ', phoneNumber: '')]));
        return;
      }

      final customers = await _customerFirebase.fetchCustomers();

      final searchResults = customers.where((customer) {
        final query = event.query.toLowerCase();
        return customer.name.toLowerCase().contains(query) ||
            customer.phoneNumber.contains(
                query);
      }).toList();

      emit(CustomerSearchSuccess(searchResults: searchResults));
    } catch (error) {
      // Emit failure state in case of an error
      emit(CustomerSearchFailed(error: error.toString()));
      print('Customer search failed: $error');
    }
  }
}
