import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';

import '../../../../features/customer/bloc/customer_bloc.dart';
import '../../../../widgets/normal_widgets/custom_customer_list_item.dart';

class CustomersListScreen extends StatelessWidget {
  const CustomersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CustomerBloc>().add(CustomerFetchStated());

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (context, state) {
          if (state is CustomerFetchInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CustomerFetchSuccess) {
            // Display list of customers
            final customers = state.customers;
            return ListView.separated(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return CustomCustomerListItem(customer: customer);
              },
              separatorBuilder: (context, index) =>  Divider(
                thickness: 1,
                color: GREY_LIGHT_COLOR,
                indent: 10,
                endIndent: 10,
              ),
            );
          } else if (state is CustomerFetchFailed) {
            return Center(
              child: Text('Failed to fetch customers: ${state.error}'),
            );
          } else {
            return const Center(child: Text('No customers available.'));
          }
        },
      ),
    );
  }
}
