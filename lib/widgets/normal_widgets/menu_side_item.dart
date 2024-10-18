import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

class MenuSideItem extends StatefulWidget {
  const MenuSideItem({
    super.key,
    required this.icon,
    this.onTap,
    this.isSelected = false,
    required this.title,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  _MenuSideItemState createState() => _MenuSideItemState();
}

class _MenuSideItemState extends State<MenuSideItem> {
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
          decoration: BoxDecoration(
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
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: widget.isSelected || _isHovered || _isPressed
                      ? PRIMARY_COLOR
                      : GREY_LIGHT_COLOR,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  widget.icon,
                  color: widget.isSelected || _isHovered || _isPressed
                      ? WHITE_COLOR
                      : GREY_COLOR,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                widget.title,
                style:  AppTextStyle.medium(
                  MEDIUM_TEXT_SIZE,
                  widget.isSelected  || _isPressed
                      ? WHITE_COLOR
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
