import 'package:flutter/material.dart';

import '../../../../utils/ui_util/app_colors.dart';
import '../../../../widgets/common_widgets/header_side.dart';
import '../../main_tablet_screen.dart';

class SettingPageTabletScreen extends StatelessWidget {
  const SettingPageTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String pageName = 'Report';
    final mainScreenState =
        context.findAncestorStateOfType<MainTabletScreenState>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderSide(
                  scaffoldKey: mainScreenState!.scaffoldKey,
                  currentPageName: pageName,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
