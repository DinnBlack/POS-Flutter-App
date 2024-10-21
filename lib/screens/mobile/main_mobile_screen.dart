import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/screens/mobile/pages/activity_page/activity_page_mobile_screen.dart';
import 'package:pos_flutter_app/screens/mobile/pages/inventory_page/inventory_page_mobile_screen.dart';
import 'package:pos_flutter_app/screens/mobile/pages/order_page/order_page_mobile_screen.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import '../../features/store/bloc/store_bloc.dart';
import '../../routes/page_routes.dart';
import '../../utils/constants/constants.dart';
import '../../widgets/common_widgets/menu_mobile.dart';

class MainMobileScreen extends StatefulWidget {
  static const route = 'MainMobileScreen';

  const MainMobileScreen({super.key});

  @override
  MainMobileScreenState createState() => MainMobileScreenState();
}

class MainMobileScreenState extends State<MainMobileScreen> {
  @override
  Widget build(BuildContext context) {
    final store = context.read<StoreBloc>().selectedStore;
    print(store);
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: PRIMARY_COLOR,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              store?.name ?? 'Cửa hàng',
              style: AppTextStyle.semibold(PLUS_LARGE_TEXT_SIZE, WHITE_COLOR),
            ),
            Text(
              store?.businessType ?? 'Loại cửa hàng',
              style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, WHITE_COLOR),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: MenuMobile(
          onItemSelected: (route) {
            switch (route) {
              case PageRoutes.activityPageMobile:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ActivityPageMobileScreen()),
                );
                break;
              case PageRoutes.inventoryPageMobile:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InventoryPageMobileScreen()),
                );
                break;
              case PageRoutes.orderPageMobile:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderPageMobileScreen()),
                );
                break;
            }
          },
        ),
      ),
    );
  }
}
