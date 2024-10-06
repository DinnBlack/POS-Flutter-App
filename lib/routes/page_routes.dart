import 'package:flutter/material.dart';
import '../screens/services/billing_queue/billing_queue_screen.dart';
import '../screens/services/orders/order_history/order_history_screen.dart';
import '../screens/services/tables/tables_screen.dart';
import '../screens/tablet/pages/activity_page/activity_page_tablet_screen.dart';
import '../screens/tablet/pages/order_page/order_page_tablet_screen.dart';
import '../screens/tablet/pages/report_page/report_page_tablet_screen.dart';
import '../screens/tablet/pages/setting_page/setting_page_tablet_screen.dart';
import '../screens/tablet/pages/staff_page/staff_page_tablet_screen.dart';

class PageRoutes {
  static const String activityPage = 'ActivityPageTabletScreen';
  static const String orderPage = 'OrderPageTabletScreen';
  static const String reportPage = 'ReportPageTabletScreen';
  static const String settingPage = 'SettingPageTabletScreen';
  static const String staffPage = 'StaffPageTabletScreen';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      activityPage: (context) => const ActivityPageTabletScreen(),
      orderPage: (context) => const OrderPageTabletScreen(),
      reportPage: (context) => const ReportPageTabletScreen(),
      settingPage: (context) => const SettingPageTabletScreen(),
      staffPage: (context) => const StaffPageTabletScreen(),
    };
  }
}

class ActivityPageRoutes {
  static const String billingQueueActivityPage = 'BillingQueueScreen';
  static const String orderHistoryActivityPage = 'OrderHistoryScreen';
  static const String tablesActivityPage = 'TablesScreen';

  static Map<String, WidgetBuilder> getActivityRoutes() {
    return {
      billingQueueActivityPage: (context) => const BillingQueueScreen(),
      orderHistoryActivityPage: (context) => const OrderHistoryScreen(),
      tablesActivityPage: (context) => const TablesScreen(),
    };
  }
}
