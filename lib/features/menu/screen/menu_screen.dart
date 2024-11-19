import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import '../../../screens/mobile/pages/activity_page/activity_page_mobile_screen.dart';
import '../../../screens/mobile/pages/customer_page/customer_page_mobile_screen.dart';
import '../../../screens/mobile/pages/inventory_page/inventory_page_mobile_screen.dart';
import '../../../screens/mobile/pages/order_page/order_page_mobile_screen.dart';
import '../../../screens/mobile/pages/report_page/report_page_mobile_screen.dart';
import '../widget/menu_item.dart';

class MenuScreen extends StatefulWidget {
  final List<String> allowedTitles;

  const MenuScreen({
    super.key,
    required this.allowedTitles,
  });

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kPaddingMd),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: kPaddingMd,
        crossAxisSpacing: kPaddingMd,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          if (widget.allowedTitles.contains('Bán hàng'))
            MenuItem(
              title: 'Bán hàng',
              icon: Iconsax.shop_add,
              iconColor: Colors.green,
              onTap: () => Navigator.pushNamed(context, OrderPageMobileScreen.route),
            ),
          if (widget.allowedTitles.contains('Sản phẩm'))
            MenuItem(
              title: 'Sản phẩm',
              icon: Icons.inventory,
              iconColor: Colors.blue,
              onTap: () => Navigator.pushNamed(context, InventoryPageMobileScreen.route),
            ),
          if (widget.allowedTitles.contains('Đơn hàng'))
            MenuItem(
              title: 'Đơn hàng',
              icon: Icons.fact_check_rounded,
              iconColor: Colors.orange,
              onTap: () => Navigator.pushNamed(context, ActivityPageMobileScreen.route),
            ),
          if (widget.allowedTitles.contains('Khách hàng'))
            MenuItem(
              title: 'Khách hàng',
              icon: Iconsax.profile_2user,
              iconColor: Colors.purple,
              onTap: () => Navigator.pushNamed(context, CustomerPageMobileScreen.route),
            ),
          if (widget.allowedTitles.contains('Báo cáo'))
            MenuItem(
              title: 'Báo cáo',
              icon: Iconsax.chart_1,
              iconColor: Colors.red,
              onTap: () => Navigator.pushNamed(context, ReportPageMobileScreen.route),
            ),
          if (widget.allowedTitles.contains('Tính năng'))
            MenuItem(
              title: 'Tính năng',
              icon: Icons.add_rounded,
              iconColor: Colors.teal,
              onTap: () => Navigator.pushNamed(context, ReportPageMobileScreen.route),
            ),

        ],
      ),
    );
  }
}
