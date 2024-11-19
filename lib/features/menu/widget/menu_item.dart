import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/app_text_style.dart';

class MenuItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final Color? iconColor;
  final Color? textColor;

  const MenuItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.textColor,
  }) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = widget.iconColor ?? kColorPrimary;
    final textColor = widget.textColor ?? kColorBlack;

    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: InkWell(
          borderRadius: BorderRadius.circular(kBorderRadiusMd),
          onTap: () {
            widget.onTap();
          },
          child: Container(
            decoration: BoxDecoration(
              color: kColorWhite,
              borderRadius: BorderRadius.circular(kBorderRadiusMd),
              border: Border.all(
                color: kColorLightGrey,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  size: 40,
                  color: iconColor,
                ),
                const SizedBox(height: kMarginMd),
                Text(
                  widget.title,
                  style: AppTextStyle.medium(kTextSizeMd, textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
