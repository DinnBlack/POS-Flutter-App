import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/ui_util/app_colors.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
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
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: widget.isSelected || _isHovered || _isPressed
                      ? AppColors.primary
                      : AppColors.grey_02,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  widget.icon,
                  color: widget.isSelected || _isHovered || _isPressed
                      ? AppColors.white
                      : AppColors.grey,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                widget.title,
                style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.isSelected  || _isPressed
                      ? AppColors.white
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
