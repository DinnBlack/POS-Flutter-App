import 'package:flutter/material.dart';
import 'package:pos_flutter_app/screens/mobile/main_mobile_screen.dart';
import 'package:pos_flutter_app/screens/services/login/login_screen.dart';

import '../screens/services/product/product_create/product_create_screen.dart';
import '../screens/services/register/register_screen.dart';
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
    default:
      return MaterialPageRoute(builder: (context) => const MainTabletScreen());
  }
}
