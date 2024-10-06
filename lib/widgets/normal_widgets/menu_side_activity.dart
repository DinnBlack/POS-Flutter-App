import 'package:flutter/material.dart';
import '../../routes/page_routes.dart';
import 'custom_text_field_search_activity.dart';
import 'menu_side_activity_item.dart';

class MenuSideActivity extends StatefulWidget {
  final Function(String) onItemSelected;
  final String selectedRoute;

  const MenuSideActivity({
    super.key,
    required this.onItemSelected,
    required this.selectedRoute,
  });

  @override
  State<MenuSideActivity> createState() => _MenuSideActivityState();
}

class _MenuSideActivityState extends State<MenuSideActivity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const CustomTextFieldSearchActivity(),
                MenuSideActivityItem(
                  title: 'Billing Queue',
                  isSelected: widget.selectedRoute ==
                      ActivityPageRoutes.billingQueueActivityPage,
                  onTap: () => _onMenuItemTapped(
                      ActivityPageRoutes.billingQueueActivityPage),
                ),
                MenuSideActivityItem(
                  title: 'Tables',
                  isSelected: widget.selectedRoute ==
                      ActivityPageRoutes.tablesActivityPage,
                  onTap: () => _onMenuItemTapped(
                      ActivityPageRoutes.tablesActivityPage),
                ),
                MenuSideActivityItem(
                  title: 'Order History',
                  isSelected: widget.selectedRoute ==
                      ActivityPageRoutes.orderHistoryActivityPage,
                  onTap: () => _onMenuItemTapped(
                      ActivityPageRoutes.orderHistoryActivityPage),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onMenuItemTapped(String route) {
    widget.onItemSelected(route);
  }
}
