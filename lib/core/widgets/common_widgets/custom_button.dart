import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Color? color; // Button background color (used when not an outline button)
  final VoidCallback onPressed;
  final bool isOutlineButton; // Flag for outline style
  final double? height; // Button height
  final IconData? icon; // Optional icon
  final Widget? iconImage; // Optional widget image
  final TextStyle? textStyle; // Custom text style
  final Color? borderColor; // Border color for outline button

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color, // Set background color
    this.isOutlineButton = false, // Default is false, meaning solid button
    this.height,
    this.icon,
    this.iconImage,
    this.textStyle,
    this.borderColor, // Set border color
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double _scale = 1.0; // For scaling effect on tap

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
    final double buttonHeight = widget.height ?? kHeightMd; // Use provided height or default
    final Color buttonColor = widget.isOutlineButton
        ? Colors.transparent // If outline, no background color
        : (widget.color ?? kColorPrimary); // If not outline, use the provided color or default primary

    final TextStyle textStyle = widget.isOutlineButton
        ? (widget.textStyle ?? AppTextStyle.medium(kTextSizeMd, widget.borderColor ?? kColorPrimary)) // Outline button text style
        : (widget.textStyle ?? AppTextStyle.medium(kTextSizeMd, Colors.white)); // Solid button text style

    final BorderSide borderSide = widget.isOutlineButton
        ? BorderSide(color: widget.borderColor ?? kColorPrimary) // Outline border color
        : BorderSide.none; // No border if not outline

    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 150), // Add smooth scale animation
      curve: Curves.easeInOut,
      child: Container(
        height: buttonHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(kBorderRadiusMd),
          border: widget.isOutlineButton ? Border.fromBorderSide(borderSide) : null, // Add border if outline
        ),
        child: InkWell(
          onTap: widget.onPressed,
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          borderRadius: BorderRadius.circular(kBorderRadiusMd),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.iconImage != null) ...[
                    widget.iconImage!,
                    const SizedBox(width: kMarginMd),
                  ] else if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      color: textStyle.color,
                      size: 18.0,
                    ),
                    const SizedBox(width: kMarginMd),
                  ],
                  Text(
                    widget.text,
                    style: textStyle, // Apply text style
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
