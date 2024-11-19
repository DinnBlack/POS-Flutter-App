import 'package:flutter/material.dart';
import 'package:pos_flutter_app/screens/mobile/main_mobile_screen.dart';
import '../features/auth/screen/login/login_screen.dart';
import '../features/auth/screen/onboarding/onboarding_screen.dart';
import '../features/auth/screen/register/register_screen.dart';
import '../features/category/screen/categories_list/category_list_screen.dart';
import '../features/category/screen/category_create/category_create_screen.dart';
import '../features/customer/screen/customer_create/customer_create_screen.dart';
import '../features/customer/screen/customer_list/customer_list_screen.dart';
import '../features/customer/screen/customer_select/customer_select_screen.dart';
import '../features/invoice/screen/invoice_details/invoice_details_screen.dart';
import '../features/order/model/order_model.dart';
import '../features/order/screen/order_create/order_create_screen.dart';
import '../features/order/screen/order_details/order_details_screen.dart';
import '../features/payment/screen/pay_order/pay_order_screen.dart';
import '../features/product/screen/product_create/product_create_screen.dart';
import '../features/search/screen/search_screen.dart';
import '../features/store/screen/store_select_screen.dart';
import '../screens/mobile/pages/activity_page/activity_page_mobile_screen.dart';
import '../screens/mobile/pages/customer_page/customer_page_mobile_screen.dart';
import '../screens/mobile/pages/inventory_page/inventory_page_mobile_screen.dart';
import '../screens/mobile/pages/order_page/order_page_mobile_screen.dart';
import '../features/store/screen/store_create_screen.dart';
import '../screens/mobile/pages/report_page/report_page_mobile_screen.dart';
import '../screens/tablet/main_tablet_screen.dart';

Route<dynamic> routes(RouteSettings settings) {
  switch (settings.name) {
    // Device
    case MainMobileScreen.route:
      return MaterialPageRoute(builder: (context) => const MainMobileScreen());
    case MainTabletScreen.route:
      return MaterialPageRoute(builder: (context) => const MainTabletScreen());

    //Pages Mobile
    case InventoryPageMobileScreen.route:
      return MaterialPageRoute(
          builder: (context) => const InventoryPageMobileScreen());
    case OrderPageMobileScreen.route:
      return MaterialPageRoute(
          builder: (context) => const OrderPageMobileScreen());
    case ActivityPageMobileScreen.route:
      return MaterialPageRoute(
          builder: (context) => const ActivityPageMobileScreen());
    case CustomerPageMobileScreen.route:
      return MaterialPageRoute(
          builder: (context) => const CustomerPageMobileScreen());
    case ReportPageMobileScreen.route:
      return MaterialPageRoute(
          builder: (context) => const ReportPageMobileScreen());


    // Authorization
    case LoginScreen.route:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case RegisterScreen.route:
      return MaterialPageRoute(builder: (context) => const RegisterScreen());
    case OnboardingScreen.route:
      return MaterialPageRoute(builder: (context) => const OnboardingScreen());

    // Categories
    case CategoryListScreen.route:
      return MaterialPageRoute(
          builder: (context) => const CategoryListScreen());
    case CategoryCreateScreen.route:
      return MaterialPageRoute(
          builder: (context) => const CategoryCreateScreen());

    // Customer
    case CustomerListScreen.route:
      return MaterialPageRoute(
          builder: (context) => const CustomerListScreen());
    case CustomerCreateScreen.route:
      return MaterialPageRoute(
          builder: (context) => const CustomerCreateScreen());
    case CustomerSelectScreen.route:
      return MaterialPageRoute(
          builder: (context) => const CustomerSelectScreen());

    // Invoice
    case InvoiceDetailsScreen.route:
      return MaterialPageRoute(
          builder: (context) => const InvoiceDetailsScreen());

    // Orders
    case OrderCreateScreen.route:
      return MaterialPageRoute(builder: (context) => const OrderCreateScreen());
    case OrderDetailsScreen.route:
      final OrderModel order = settings.arguments as OrderModel;
      return MaterialPageRoute(
        builder: (context) => OrderDetailsScreen(
          order: order,
        ),
      );
    case PayOrderScreen.route:
      return MaterialPageRoute(builder: (context) => const PayOrderScreen());
    case OrderPageMobileScreen.route:
      return MaterialPageRoute(
          builder: (context) => const OrderPageMobileScreen());

    // Products
    case ProductCreateScreen.route:
      return MaterialPageRoute(
          builder: (context) => const ProductCreateScreen());

    // Search
    case SearchScreen.route:
      return MaterialPageRoute(builder: (context) => const SearchScreen());

    // Stores
    case StoreSelectScreen.route:
      return MaterialPageRoute(builder: (context) => const StoreSelectScreen());
    case StoreCreateScreen.route:
      return MaterialPageRoute(builder: (context) => const StoreCreateScreen());

    // Default
    default:
      return MaterialPageRoute(builder: (context) => const MainTabletScreen());
  }
}
