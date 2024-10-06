import 'package:flutter/material.dart';
import 'package:pos_flutter_app/screens/tablet/pages/activity_page/activity_page_tablet_screen.dart';
import 'package:pos_flutter_app/screens/tablet/pages/order_page/order_page_tablet_screen.dart';
import 'package:pos_flutter_app/screens/tablet/pages/report_page/report_page_tablet_screen.dart';
import 'package:pos_flutter_app/screens/tablet/pages/setting_page/setting_page_tablet_screen.dart';
import 'package:pos_flutter_app/screens/tablet/pages/staff_page/staff_page_tablet_screen.dart';
import 'package:pos_flutter_app/utils/ui_util/app_colors.dart';
import 'package:pos_flutter_app/widgets/common_widgets/menu_side.dart';
import '../../routes/page_routes.dart';

class MainTabletScreen extends StatefulWidget {
  static const route = 'MainTabletScreen';

  const MainTabletScreen({super.key});

  @override
  MainTabletScreenState createState() => MainTabletScreenState();
}

class MainTabletScreenState extends State<MainTabletScreen> {
  String currentRoute = PageRoutes.activityPage;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void updateRoute(String route) {
    setState(() {
      currentRoute = route;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: MenuSide(
        onItemSelected: updateRoute,
        selectedRoute: currentRoute,
      ),
      key: scaffoldKey,
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
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
      case PageRoutes.activityPage:
        return const ActivityPageTabletScreen();
      case PageRoutes.reportPage:
        return const ReportPageTabletScreen();
      case PageRoutes.staffPage:
        return const StaffPageTabletScreen();
      case PageRoutes.settingPage:
        return const SettingPageTabletScreen();
      case PageRoutes.orderPage:
      default:
        return const OrderPageTabletScreen();
    }
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }
}
