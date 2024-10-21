import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

import '../../routes/page_routes.dart';

class MenuMobile extends StatelessWidget {
  final Function(String) onItemSelected;

  const MenuMobile({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(DEFAULT_PADDING),
        mainAxisSpacing: DEFAULT_PADDING,
        crossAxisSpacing: DEFAULT_PADDING,
        children: [
          _buildMenuItem(
            context,
            'Orders',
            Icons.list,
            Colors.blue,
            PageRoutes.orderPageMobile,
          ),
          _buildMenuItem(
            context,
            'Inventory',
            Icons.inventory,
            Colors.green,
            PageRoutes.inventoryPageMobile,
          ),
          _buildMenuItem(
            context,
            'Activity',
            Icons.wordpress,
            Colors.orange,
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
            Icon(icon, size: 50.0, color: Colors.white),
            const SizedBox(height: DEFAULT_MARGIN),
            Text(
              title,
              style: AppTextStyle.semibold(PLUS_LARGE_TEXT_SIZE, WHITE_COLOR),
            ),
          ],
        ),
      ),
    );
  }
}
