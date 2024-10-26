import 'package:flutter/material.dart';
import 'package:pos_flutter_app/screens/services/billing_queue/billing_queue_screen.dart';

import '../../../../routes/page_routes.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../widgets/common_widgets/header_side.dart';
import '../../../../widgets/normal_widgets/menu_side_activity.dart';
import '../../../services/order/order_history/order_history_screen.dart';
import '../../../services/table/tables_screen.dart';
import '../../main_tablet_screen.dart';

class ActivityPageTabletScreen extends StatefulWidget {
  const ActivityPageTabletScreen({super.key});

  @override
  State<ActivityPageTabletScreen> createState() =>
      _ActivityPageTabletScreenState();
}

class _ActivityPageTabletScreenState extends State<ActivityPageTabletScreen> {
  String currentRoute = ActivityPageRoutes.billingQueueActivityPage;
  String pageName = 'Activity';

  void updateRoute(String route) {
    setState(() {
      currentRoute = route;
    });
  }

  String get currentPageName {
    switch (currentRoute) {
      case ActivityPageRoutes.billingQueueActivityPage:
        return "Billing Queue";
      case ActivityPageRoutes.tablesActivityPage:
        return "Tables";
      case ActivityPageRoutes.orderHistoryActivityPage:
        return "Order History";
      default:
        return "Unknown Page";
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainScreenState =
        context.findAncestorStateOfType<MainTabletScreenState>();

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: Column(
        children: [
          HeaderSide(
            scaffoldKey: mainScreenState!.scaffoldKey,
            currentPageName: pageName,
            subPageName: currentPageName,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: MenuSideActivity(
                    onItemSelected: updateRoute,
                    selectedRoute: currentRoute,
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: _getPage(currentRoute),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPage(String route) {
    switch (route) {
      case ActivityPageRoutes.billingQueueActivityPage:
        return const BillingQueueScreen();
      case ActivityPageRoutes.tablesActivityPage:
        return const TablesScreen();
      case ActivityPageRoutes.orderHistoryActivityPage:
        return const OrderHistoryScreen();
      default:
        return const OrderHistoryScreen();
    }
  }
}
