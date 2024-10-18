import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import '../orders/track_orders/track_orders_screen.dart';

class BillingQueueScreen extends StatefulWidget {
  const BillingQueueScreen({super.key});

  @override
  _BillingQueueScreenState createState() => _BillingQueueScreenState();
}

class _BillingQueueScreenState extends State<BillingQueueScreen> {
  String selectedStatus = 'All';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
      ),
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 10,),
          const TrackOrdersScreen(),
        ],
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
          _buildStatusButton('All'),
          const SizedBox(width: 10), 
          _buildStatusButton('Active'),
          const SizedBox(width: 10),
          _buildStatusButton('Close'),
        ],
      ),
    );
  }

  Widget _buildStatusButton(String status) {
    bool isSelected = selectedStatus == status;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedStatus = status;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: DEFAULT_PADDING),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              width: 1,
              color: isSelected ? PRIMARY_COLOR : GREY_LIGHT_COLOR,
            ),
            color: isSelected ? Colors.white : GREY_LIGHT_COLOR,
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              color: isSelected ? PRIMARY_COLOR : Colors.black,
            ),
            child: Text(status),
          ),
        ),
      ),
    );
  }
}
