import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import '../../screens/services/time/time_display_screen.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Menu button
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: WHITE_COLOR,
                  borderRadius: BorderRadius.circular(LARGE_BORDER_RADIUS),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR.withOpacity(0.04),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: PRIMARY_COLOR,
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
                    if (constraints.maxWidth < 800 && constraints.maxWidth > 600) const TimeDisplayScreen(),
                    if (constraints.maxWidth >= 800) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            currentPageName,
                            style: AppTextStyle.semibold(LARGE_TEXT_SIZE, BLACK_TEXT_COLOR),
                          ),
                          if (subPageName != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              ' / $subPageName',
                              style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, LIGHT_BLACK_TEXT_COLOR),
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
