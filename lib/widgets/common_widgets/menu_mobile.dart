import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

import '../../routes/page_routes.dart';

class MenuMobile extends StatelessWidget {
  final Function(String) onItemSelected;

  const MenuMobile({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(  // Use a Container instead of Scaffold
      color: BACKGROUND_COLOR,
      padding: const EdgeInsets.all(DEFAULT_PADDING),
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: DEFAULT_PADDING,
        crossAxisSpacing: DEFAULT_PADDING,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,  // Allow the GridView to wrap its height
        children: [
          _buildMenuItem(
            context,
            'Bán hàng',
            Iconsax.shop_add,
            Colors.blue,
            PageRoutes.orderPageMobile,
          ),
          _buildMenuItem(
            context,
            'Sản phẩm',
            Icons.inventory,
            Colors.green,
            PageRoutes.inventoryPageMobile,
          ),
          _buildMenuItem(
            context,
            'Đơn hàng',
            Icons.fact_check_rounded,
            Colors.orange,
            PageRoutes.activityPageMobile,
          ),
          _buildMenuItem(
            context,
            'Khách hàng',
            Iconsax.profile_2user,
            Colors.blue,
            PageRoutes.orderPageMobile,
          ),
          _buildMenuItem(
            context,
            'Báo cáo',
            Iconsax.chart_1,
            Colors.green,
            PageRoutes.inventoryPageMobile,
          ),
          _buildMenuItem(
            context,
            'Tính năng',
            Icons.add_rounded,
            GREY_COLOR,
            PageRoutes.activityPageMobile,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon,
      Color color, String route) {
    return GestureDetector(
      onTap: () {
        onItemSelected(route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: DEFAULT_MARGIN),
            Text(
              title,
              style: AppTextStyle.semibold(MEDIUM_TEXT_SIZE, WHITE_COLOR),
            ),
          ],
        ),
      ),
    );
  }
}
