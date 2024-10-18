import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
            color: widget.isSelected
                ? PRIMARY_COLOR
                : _isPressed
                    ? PRIMARY_COLOR.withOpacity(0.7)
                    : _isHovered
                        ? PRIMARY_COLOR.withOpacity(0.1)
                        : Colors.white,
          ),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title,
            style: AppTextStyle.medium(
              MEDIUM_TEXT_SIZE,
              widget.isSelected || _isPressed ? WHITE_COLOR : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
