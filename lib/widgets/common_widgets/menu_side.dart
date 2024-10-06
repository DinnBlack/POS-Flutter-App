import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/utils/ui_util/app_colors.dart';
import '../../routes/page_routes.dart';
import '../normal_widgets/menu_side_item.dart';
import '../normal_widgets/menu_side_item_logout.dart';

class MenuSide extends StatefulWidget {
  final Function(String) onItemSelected;
  final String selectedRoute;

  const MenuSide({
    super.key,
    required this.onItemSelected,
    required this.selectedRoute,
  });

  @override
  State<MenuSide> createState() => _MenuSideState();
}

class _MenuSideState extends State<MenuSide> {
  String selectedRoute = PageRoutes.orderPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: AppColors.white,
      child: Column(
        children: [
          const MenuSideItemLogout(),
          const SizedBox(height: 60),
          Expanded(
            child: ListView(
              children: [
                MenuSideItem(
                  title: 'Point Of Sales',
                  icon: Iconsax.shopping_bag_copy,
                  isSelected: widget.selectedRoute == PageRoutes.orderPage,
                  onTap: () => _onMenuItemTapped(PageRoutes.orderPage),
                ),
                MenuSideItem(
                  title: 'Activity',
                  icon: Iconsax.trend_up_copy,
                  isSelected: widget.selectedRoute == PageRoutes.activityPage,
                  onTap: () => _onMenuItemTapped(PageRoutes.activityPage),
                ),
                MenuSideItem(
                  title: 'Report',
                  icon: Iconsax.chart_3_copy,
                  isSelected: widget.selectedRoute == PageRoutes.reportPage,
                  onTap: () => _onMenuItemTapped(PageRoutes.reportPage),
                ),
                MenuSideItem(
                  title: 'Teams',
                  icon: Iconsax.profile_2user_copy,
                  isSelected: widget.selectedRoute == PageRoutes.staffPage,
                  onTap: () => _onMenuItemTapped(PageRoutes.staffPage),
                ),
                MenuSideItem(
                  title: 'Settings',
                  icon: Iconsax.setting_2_copy,
                  isSelected: widget.selectedRoute == PageRoutes.settingPage,
                  onTap: () => _onMenuItemTapped(PageRoutes.settingPage),
                ),
                MenuSideItem(
                  title: 'App Information',
                  icon: Iconsax.info_circle_copy,
                  onTap: () => _showInfoDialog(context),
                ),
              ],
            ),
          ),
          const MenuSideItemLogout(),
        ],
      ),
    );
  }

  void _onMenuItemTapped(String route) {
    if (mounted) {
      setState(() {
        selectedRoute = route;
      });
      widget.onItemSelected(route);
      Navigator.of(context).pop();
    }
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông tin ứng dụng'),
          content: const Text('Thông tin chi tiết về ứng dụng của bạn.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}
