import 'package:flutter/material.dart';
import 'package:pos_flutter_app/screens/mobile/main_mobile_screen.dart';
import 'package:pos_flutter_app/screens/services/login/login_screen.dart';

import '../screens/mobile/pages/order_page/order_page_mobile_screen.dart';
import '../screens/services/customer/customer_create/customer_create_screen.dart';
import '../screens/services/invoice/invoice_details/invoice_details_screen.dart';
import '../screens/services/order/order_create/order_create_screen.dart';
import '../screens/services/pay/pay_order/pay_order_screen.dart';
import '../screens/services/product/product_create/product_create_screen.dart';
import '../screens/services/register/register_screen.dart';
import '../screens/services/search/search_screen.dart';
import '../screens/services/store/store_create_screen.dart';
import '../screens/services/store/store_select_screen.dart';
import '../screens/tablet/main_tablet_screen.dart';

Route<dynamic?> appRoutes(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.route:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case RegisterScreen.route:
      return MaterialPageRoute(builder: (context) => const RegisterScreen());
    case StoreSelectScreen.route:
      return MaterialPageRoute(builder: (context) => const StoreSelectScreen());
    case StoreCreateScreen.route:
      return MaterialPageRoute(builder: (context) => const StoreCreateScreen());
    case ProductCreateScreen.route:
      return MaterialPageRoute(
          builder: (context) => const ProductCreateScreen());
    case MainMobileScreen.route:
      return MaterialPageRoute(builder: (context) => const MainMobileScreen());
    case MainTabletScreen.route:
      return MaterialPageRoute(builder: (context) => const MainTabletScreen());
    case OrderCreateScreen.route:
      return MaterialPageRoute(builder: (context) => const OrderCreateScreen());
    case PayOrderScreen.route:
      return MaterialPageRoute(builder: (context) => const PayOrderScreen());
    case InvoiceDetailsScreen.route:
      return MaterialPageRoute(builder: (context) => const InvoiceDetailsScreen());
    case OrderPageMobileScreen.route:
      return MaterialPageRoute(builder: (context) => const OrderPageMobileScreen());
    case CustomerCreateScreen.route:
      return MaterialPageRoute(builder: (context) => const CustomerCreateScreen());
    case SearchScreen.route:
      return MaterialPageRoute(builder: (context) => const SearchScreen());
    default:
      return MaterialPageRoute(builder: (context) => const MainTabletScreen());
  }
}
