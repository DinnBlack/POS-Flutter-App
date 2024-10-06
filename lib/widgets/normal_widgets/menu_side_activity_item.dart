import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/ui_util/app_colors.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.isSelected
                ? AppColors.primary
                : _isPressed
                    ? AppColors.primary.withOpacity(0.7)
                    : _isHovered
                        ? AppColors.primary.withOpacity(0.1)
                        : Colors.white,
          ),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.isSelected || _isPressed
                  ? AppColors.white
                  : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
