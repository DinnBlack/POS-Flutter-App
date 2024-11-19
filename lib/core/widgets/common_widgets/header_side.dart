import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';
import 'package:pos_flutter_app/core/widgets/common_widgets/time_display_screen.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Menu button
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kColorWhite,
                  borderRadius: BorderRadius.circular(kBorderRadiusLg),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: kColorPrimary.withOpacity(0.04),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: kColorPrimary,
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
                            style: AppTextStyle.semibold(kTextSizeLg),
                          ),
                          if (subPageName != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              ' / $subPageName',
                              style: AppTextStyle.medium(kTextSizeMd),
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
