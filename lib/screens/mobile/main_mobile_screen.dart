import 'package:flutter/material.dart';
import 'package:pos_flutter_app/screens/mobile/pages/activity_page/activity_page_mobile_screen.dart';
import 'package:pos_flutter_app/screens/mobile/pages/inventory_page/inventory_page_mobile_screen.dart';
import 'package:pos_flutter_app/screens/mobile/pages/order_page/order_page_mobile_screen.dart';
import 'package:pos_flutter_app/widgets/common_widgets/menu_side.dart';
import '../../models/store_model.dart';
import '../../routes/page_routes.dart';
import '../../utils/constants/constants.dart';

class MainMobileScreen extends StatefulWidget {
  static const route = 'MainMobileScreen';
  final StoreModel store;

  const MainMobileScreen({super.key, required this.store});

  @override
  MainMobileScreenState createState() => MainMobileScreenState();
}

class MainMobileScreenState extends State<MainMobileScreen> {
  String currentRoute = PageRoutes.orderPageMobile;
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
    final arguments = ModalRoute.of(context)!.settings.arguments;
    
    print(widget.store!);
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      drawer: MenuSide(
        onItemSelected: updateRoute,
        selectedRoute: currentRoute,
      ),
      key: scaffoldKey,
appBar: AppBar(
  title: Text(widget.store.name),
),
      body: Column(
        children: [
          Expanded(
            child: _getPage(currentRoute),
          ),
        ],
      ),
    );
  }


  Widget _getPage(String route) {
    switch (route) {
      case PageRoutes.activityPageMobile:
        return const ActivityPageMobileScreen();
      case PageRoutes.inventoryPageMobile:
        return const InventoryPageMobileScreen();
      default:
        return const OrderPageMobileScreen();
    }
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }
}
