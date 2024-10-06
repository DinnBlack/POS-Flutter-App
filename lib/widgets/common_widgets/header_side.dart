import 'package:flutter/material.dart';
import '../../screens/services/time/time_display_screen.dart';
import '../../utils/ui_util/app_colors.dart';
import '../normal_widgets/custom_toggle_order_status.dart';

class HeaderSide extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String currentPageName;
  final String? subPageName;

  const HeaderSide({
    super.key,
    required this.scaffoldKey,
    required this.currentPageName,
    this.subPageName,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 80,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Menu button
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.04),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (constraints.maxWidth < 800) const TimeDisplayScreen(),
                    if (constraints.maxWidth >= 800) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            currentPageName,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          if (subPageName != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              ' / $subPageName',
                              style: const TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ],
                      ),
                    ],
                    const Spacer(),
                    if (constraints.maxWidth >= 800) const TimeDisplayScreen(),
                    const SizedBox(width: 20),
                    const CustomToggleOrderStatus(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
