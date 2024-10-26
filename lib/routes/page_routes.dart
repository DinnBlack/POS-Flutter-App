import 'package:flutter/material.dart';
import '../screens/mobile/pages/activity_page/activity_page_mobile_screen.dart';
import '../screens/mobile/pages/inventory_page/inventory_page_mobile_screen.dart';
import '../screens/mobile/pages/order_page/order_page_mobile_screen.dart';
import '../screens/services/billing_queue/billing_queue_screen.dart';
import '../screens/services/order/order_history/order_history_screen.dart';
import '../screens/services/table/tables_screen.dart';
import '../screens/tablet/pages/activity_page/activity_page_tablet_screen.dart';
import '../screens/tablet/pages/order_page/order_page_tablet_screen.dart';
import '../screens/tablet/pages/report_page/report_page_tablet_screen.dart';
import '../screens/tablet/pages/setting_page/setting_page_tablet_screen.dart';
import '../screens/tablet/pages/staff_page/staff_page_tablet_screen.dart';

class PageRoutes {
  // tablet devices
  static const String activityPageTablet = 'ActivityPageTabletScreen';
  static const String orderPageTablet = 'OrderPageTabletScreen';
  static const String reportPageTablet = 'ReportPageTabletScreen';
  static const String settingPageTablet = 'SettingPageTabletScreen';
  static const String staffPageTablet = 'StaffPageTabletScreen';

  static Map<String, WidgetBuilder> getTabletRoutes() {
    return {
      activityPageTablet: (context) => const ActivityPageTabletScreen(),
      orderPageTablet: (context) => const OrderPageTabletScreen(),
      reportPageTablet: (context) => const ReportPageTabletScreen(),
      settingPageTablet: (context) => const SettingPageTabletScreen(),
      staffPageTablet: (context) => const StaffPageTabletScreen(),
    };
  }

  // mobile devices
  static const String activityPageMobile = 'ActivityPageMobileScreen';
  static const String orderPageMobile = 'OrderPageMobileScreen';
  static const String inventoryPageMobile = 'InventoryPageMobileScreen';

  static Map<String, WidgetBuilder> getMobileRoutes() {
    return {
      activityPageMobile: (context) => const ActivityPageMobileScreen(),
      orderPageMobile: (context) => const OrderPageMobileScreen(),
      inventoryPageMobile: (context) => const InventoryPageMobileScreen(),
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
