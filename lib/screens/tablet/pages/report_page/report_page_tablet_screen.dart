import 'package:flutter/material.dart';

import '../../../../utils/ui_util/app_colors.dart';
import '../../../../widgets/common_widgets/header_side.dart';
import '../../main_tablet_screen.dart';

class ReportPageTabletScreen extends StatelessWidget {
  const ReportPageTabletScreen({super.key});

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
