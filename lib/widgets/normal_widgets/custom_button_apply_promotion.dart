import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';

class CustomButtonApplyPromotion extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final String selectedText;

  const CustomButtonApplyPromotion({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.selectedText,
  }) : super(key: key);

  @override
  _CustomButtonApplyPromotionState createState() =>
      _CustomButtonApplyPromotionState();
}

class _CustomButtonApplyPromotionState
    extends State<CustomButtonApplyPromotion> {
  bool _isHovered = false;
  bool _isSelected = false;

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          _toggleSelection();
          widget.onPressed();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
          decoration: BoxDecoration(
            color: _isSelected
                ? Colors.green.withOpacity(0.2)
                : (_isHovered ? Colors.white : WHITE_COLOR),
            border: Border.all(
                color:
                    _isHovered || _isSelected ? GREEN_COLOR : GREY_COLOR),
            borderRadius: BorderRadius.circular(MEDIUM_BORDER_RADIUS),
          ),
          alignment: Alignment.center,
          curve: Curves.easeInOut,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  _isSelected ? widget.selectedText : widget.text,
                  key: ValueKey<bool>(_isSelected),
                  style: TextStyle(
                    color: _isSelected
                        ? GREEN_COLOR
                        : (_isHovered ? GREEN_COLOR : BLACK_TEXT_COLOR),
                  ),
                ),
              ),
              Icon(
                Iconsax.discount_shape,
                color: _isSelected
                    ? GREEN_COLOR
                    : (_isHovered ? GREEN_COLOR : BLACK_TEXT_COLOR),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
