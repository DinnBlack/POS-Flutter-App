import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/widgets/normal_widgets/custom_orders_list_item.dart';

import '../../../../features/order/bloc/order_bloc.dart';

class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({super.key});

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(OrderFetchStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderFetchInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OrderFetchSuccess) {
            final orders = state.orders;

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return Padding(
                  padding: EdgeInsets.only(
                    top: index == 0 ? DEFAULT_PADDING : 0,
                    bottom: DEFAULT_PADDING,
                    left: DEFAULT_PADDING,
                    right: DEFAULT_PADDING,
                  ),
                  child: CustomOrdersListItem(
                    order: order,
                  ),
                );
              },
            );
          } else if (state is OrderFetchFailure) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else {
            return const Center(
              child: Text('No orders to display'),
            );
          }
        },
      ),
    );
  }
}
