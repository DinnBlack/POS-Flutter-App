import 'package:go_router/go_router.dart';
import 'package:pos_flutter_app/screens/tablet/main_tablet_screen.dart';

import '../screens/services/login/login_screen.dart';
import '../screens/services/register/register_screen.dart';

class RouteName {
  static const String home = "/";
  static const String login = "/login";
  static const String register = "/register";
  static const String profile = "/profile";

  static const publicRoutes = [
    login,
    register,
  ];
}

final router = GoRouter(
  redirect: (context, state) {
    if (RouteName.publicRoutes.contains(state.fullPath)) {
      return null;
    } else {
      return RouteName.login;
    }
  },
  routes: [
    GoRoute(
      path: RouteName.home,
      builder: (context, state) => const MainTabletScreen(),
    ),
    GoRoute(
      path: RouteName.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteName.register,
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
