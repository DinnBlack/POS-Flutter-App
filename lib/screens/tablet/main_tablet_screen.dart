import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';

class MainTabletScreen extends StatefulWidget {
  static const route = 'MainTabletScreen';

  const MainTabletScreen({super.key});

  @override
  MainTabletScreenState createState() => MainTabletScreenState();
}

class MainTabletScreenState extends State<MainTabletScreen> {
  // String currentRoute = PageRoutes.activityPageTablet;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void updateRoute(String route) {
    setState(() {
      // currentRoute = route;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      // drawer: MenuSide(
      //   onItemSelected: updateRoute,
      //   selectedRoute: currentRoute,
      // ),
      key: scaffoldKey,
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                // Expanded(
                //   child: _getPage(currentRoute),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _getPage(String route) {
  //   switch (route) {
  //     // case PageRoutes.activityPageTablet:
  //     //   return const ActivityPageTabletScreen();
  //     // case PageRoutes.reportPageTablet:
  //     //   return const ReportPageTabletScreen();
  //     // case PageRoutes.staffPageTablet:
  //     //   return const StaffPageTabletScreen();
  //     // case PageRoutes.settingPageTablet:
  //     //   return const SettingPageTabletScreen();
  //     // case PageRoutes.orderPageTablet:
  //     // default:
  //     //   return const OrderPageTabletScreen();
  //   }
  // }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }
}
