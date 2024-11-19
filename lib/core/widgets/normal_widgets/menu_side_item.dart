import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
          decoration: BoxDecoration(
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
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: widget.isSelected || _isHovered || _isPressed
                      ? kColorPrimary
                      : kColorGrey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  widget.icon,
                  color: widget.isSelected || _isHovered || _isPressed
                      ? kColorWhite
                      : kColorGrey,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                widget.title,
                style:  AppTextStyle.medium(
                  kTextSizeMd,
                  widget.isSelected  || _isPressed
                      ? kColorWhite
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
