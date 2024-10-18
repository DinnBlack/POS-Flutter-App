import 'package:flutter/material.dart';

import '../../../../utils/constants/constants.dart';
import '../../../../widgets/common_widgets/header_side.dart';
import '../../main_tablet_screen.dart';

class StaffPageTabletScreen extends StatelessWidget {
  const StaffPageTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String pageName = 'Staff';
    final mainScreenState =
        context.findAncestorStateOfType<MainTabletScreenState>();

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
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
