import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import '../../utils/app_text_style.dart';

class CustomTabBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabTapped;
  final List<String> tabTitles;
  final double lineHeight;
  final double tabBarHeight;

  const CustomTabBar({
    Key? key,
    required this.currentIndex,
    required this.onTabTapped,
    required this.tabTitles,
    this.lineHeight = 2,
    this.tabBarHeight = 40.0,
  }) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    double tabWidth = 100.0; // Chiều rộng cố định cho mỗi tab

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // SingleChildScrollView chứa các tiêu đề
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(widget.tabTitles.length, (index) {
              return GestureDetector(
                onTap: () => widget.onTabTapped(index),
                child: Container(
                  width: tabWidth,
                  alignment: Alignment.center,
                  child: Text(
                    widget.tabTitles[index],
                    style: AppTextStyle.medium(
                      kTextSizeMd,
                      widget.currentIndex == index ? kColorPrimary : kColorGrey,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        // SingleChildScrollView chứa đường line
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(left: widget.currentIndex * tabWidth),
                width: tabWidth,
                height: widget.lineHeight,
                decoration: BoxDecoration(
                  color: kColorPrimary,
                  borderRadius: BorderRadius.circular(kBorderRadiusXl),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
