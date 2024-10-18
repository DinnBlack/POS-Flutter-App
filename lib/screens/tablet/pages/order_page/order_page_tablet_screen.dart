import 'package:flutter/material.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_text_field_search.dart';

import '../../../../utils/constants/constants.dart';
import '../../../../widgets/common_widgets/header_side.dart';
import '../../../services/categories/list_categories_screen.dart';
import '../../../services/orders/order_details/order_details_page/order_details_page_screen.dart';
import '../../../services/products/list_products/list_products_screen.dart';
import '../../main_tablet_screen.dart';

class OrderPageTabletScreen extends StatelessWidget {
  const OrderPageTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String pageName = 'Order';
    final mainScreenState =
        context.findAncestorStateOfType<MainTabletScreenState>();

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderSide(
                  scaffoldKey: mainScreenState!.scaffoldKey,
                  currentPageName: pageName,
                ),
                const ListCategoriesScreen(),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextFieldSearch(),
                ),
                const Expanded(
                  child: ListProductsScreen(),
                ),
              ],
            ),
          ),
          const Flexible(
            flex: 1,
            child: OrderDetailsPageScreen(),
          ),
        ],
      ),
    );
  }
}
