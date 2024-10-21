import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';

import '../../../../database/db_orders.dart';
import '../../../../models/order_model.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late DateTime _startDate;
  late TimeOfDay _startTime;
  late DateTime _endDate;
  late TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now().subtract(const Duration(days: 7));
    _startTime = TimeOfDay.now();
    _endDate = DateTime.now();
    _endTime = TimeOfDay.now();
  }

  void _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          if (pickedDate.isAfter(_endDate)) {
            _showErrorDialog('Start date cannot be after the end date.');
          } else {
            _startDate = pickedDate;
          }
        } else {
          if (pickedDate.isBefore(_startDate)) {
            _showErrorDialog('End date cannot be before the start date.');
          } else {
            _endDate = pickedDate;
          }
        }
      });
    }
  }

  void _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          if (_compareDateTime(_startDate, pickedTime, _endDate, _endTime) > 0) {
            _showErrorDialog('Start time cannot be after the end time.');
          } else {
            _startTime = pickedTime;
          }
        } else {
          if (_compareDateTime(_startDate, _startTime, _endDate, pickedTime) > 0) {
            _showErrorDialog('End time cannot be before the start time.');
          } else {
            _endTime = pickedTime;
          }
        }
      });
    }
  }

  int _compareDateTime(DateTime startDate, TimeOfDay startTime, DateTime endDate, TimeOfDay endTime) {
    final start = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );
    final end = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      endTime.hour,
      endTime.minute,
    );
    return start.compareTo(end);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Invalid Selection'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(
        color: WHITE_COLOR,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DEFAULT_BORDER_RADIUS),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildTitleRow(),
          Expanded(
            child: _buildOrderList(),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildDateContainer({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: DEFAULT_PADDING),
        decoration: BoxDecoration(
          color: WHITE_COLOR,
          borderRadius: BorderRadius.circular(LARGE_BORDER_RADIUS),
          border: Border.all(
            color: GREY_COLOR.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            const Icon(Iconsax.calendar_1_copy, color: PRIMARY_COLOR),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeContainer({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: DEFAULT_PADDING),
        decoration: BoxDecoration(
          color: WHITE_COLOR,
          borderRadius: BorderRadius.circular(LARGE_BORDER_RADIUS),
          border: Border.all(
            color: GREY_COLOR.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            const Icon(Iconsax.clock_copy, color: PRIMARY_COLOR),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(DEFAULT_PADDING),
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(DEFAULT_BORDER_RADIUS)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            'Date: ',
          ),
          _buildDateContainer(
            label: DateFormat('dd/MM/yyyy').format(_startDate),
            onTap: () => _selectDate(context, true),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
            child: Text(
              '-',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          _buildDateContainer(
            label: DateFormat('dd/MM/yyyy').format(_endDate),
            onTap: () => _selectDate(context, false),
          ),
          const SizedBox(width: 20,),
          const Text(
            'Time: ',
          ),
          _buildTimeContainer(
            label: _startTime.format(context),
            onTap: () => _selectTime(context, true),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
            child: Text(
              '-',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          _buildTimeContainer(
            label: _endTime.format(context),
            onTap: () => _selectTime(context, false),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: GREY_COLOR.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.search_rounded,
                color: GREY_COLOR,
              ),
              onPressed: () {
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: WHITE_COLOR,
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: GREY_COLOR.withOpacity(0.2),
              ),
            ),
            child: IconButton(
              icon: const Icon(
                Iconsax.filter_copy,
                color: GREY_COLOR,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleRow() {
    return const Padding(
      padding: EdgeInsets.all(DEFAULT_PADDING),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: CustomTitle(
              title: '#',
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomTitle(
              title: 'Date & Time',
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomTitle(title: 'Customer'),
          ),
          Expanded(
            flex: 2,
            child: CustomTitle(
              title: 'Order Status',
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomTitle(
              title: 'Total Payment',
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomTitle(
              title: 'Payment Status',
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomTitle(
              title: 'Orders',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
      child: ListView.builder(
        itemCount: dbOrders.length,
        itemBuilder: (context, index) {
          final order = dbOrders[index];
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: GREY_LIGHT_COLOR),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomContent(
                    text: order.orderId,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CustomContent(
                    text: DateFormat('dd/MM/yyyy hh:mm a')
                        .format(order.orderTime),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CustomContent(
                    text: order.customerName,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CustomContent(
                    text: order.status,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CustomContent(
                    text: '\$${order.totalPrice.toStringAsFixed(2)}',
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: DEFAULT_PADDING),
                      decoration: BoxDecoration(
                        color: order.paymentStatus
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(LARGE_BORDER_RADIUS),
                      ),
                      child: Text(
                        order.paymentStatus ? 'Paid' : 'Unpaid',
                        style: TextStyle(
                          color:
                              order.paymentStatus ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _showOrderDetails(order);
                      },
                      child: const Text(
                        'Detail',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showOrderDetails(OrderModel order) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Order Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...order.products.map((product) => ListTile(
                    title: Text(product.title),
                    trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                  )),
              const Divider(),
              Text('Total Payment: \$${order.totalPrice.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(DEFAULT_PADDING),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Total Orders: ${dbOrders.length}'),
        ],
      ),
    );
  }
}

class CustomContent extends StatelessWidget {
  const CustomContent({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MEDIUM_BORDER_RADIUS),
        color: GREY_LIGHT_COLOR,
      ),
      alignment: Alignment.center,
      child: Text(
        title,
      ),
    );
  }
}
