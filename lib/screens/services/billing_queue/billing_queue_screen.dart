import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/ui_util/app_colors.dart';
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
        borderRadius: BorderRadius.circular(10),
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
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
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              width: 1,
              color: isSelected ? AppColors.primary : AppColors.grey_02,
            ),
            color: isSelected ? Colors.white : AppColors.grey_02,
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              color: isSelected ? AppColors.primary : Colors.black,
            ),
            child: Text(status),
          ),
        ),
      ),
    );
  }
}
