import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';

class MenuSideActivityItem extends StatefulWidget {
  const MenuSideActivityItem({
    super.key,
    this.onTap,
    this.isSelected = false,
    required this.title,
  });

  final String title;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  _MenuSideActivityItemState createState() => _MenuSideActivityItemState();
}

class _MenuSideActivityItemState extends State<MenuSideActivityItem> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadiusMd),
            color: widget.isSelected
                ? kColorPrimary
                : _isPressed
                    ? kColorPrimary.withOpacity(0.7)
                    : _isHovered
                        ? kColorPrimary.withOpacity(0.1)
                        : Colors.white,
          ),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title,
            style: AppTextStyle.medium(
              kTextSizeMd,
              widget.isSelected || _isPressed ? kColorWhite : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
