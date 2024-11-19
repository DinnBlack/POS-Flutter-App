import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import '../../widget/custom_orders_list_item.dart';
import '../../../../features/order/bloc/order_bloc.dart';
import 'empty_order_list_screen.dart';

class OrdersListScreen extends StatefulWidget {
  final String? status;
  final String? sortBy;

  const OrdersListScreen({super.key, this.status, this.sortBy});

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context
        .read<OrderBloc>()
        .add(OrderFetchStarted(status: widget.status, sortBy: widget.sortBy));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refreshOrders() async {
    context
        .read<OrderBloc>()
        .add(OrderFetchStarted(status: widget.status, sortBy: widget.sortBy));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderFetchInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OrderFetchSuccess) {
            final orders = state.orders;

            if (orders.isEmpty) {
              return const EmptyOrderListScreen();
            }

            return RefreshIndicator(
              onRefresh: _refreshOrders,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];

                  return Padding(
                    padding: EdgeInsets.only(
                      top: index == 0 ? kPaddingMd : 0,
                      bottom: kPaddingMd,
                      left: kPaddingMd,
                      right: kPaddingMd,
                    ),
                    child: CustomOrdersListItem(
                      order: order,
                    ),
                  );
                },
              ),
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
