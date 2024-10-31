import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import '../../utils/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback onPressed;
  final bool isOutlineButton;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.isOutlineButton = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = height ?? DEFAULT_HEIGHT;
    final Color buttonColor = isOutlineButton ? Colors.white : (color ?? PRIMARY_COLOR);
    final Color textColor = isOutlineButton ? PRIMARY_COLOR : Colors.white;
    final BorderSide borderSide = isOutlineButton ? const BorderSide(color: PRIMARY_COLOR) : BorderSide.none;

    return Container(
      height: buttonHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(SMALL_BORDER_RADIUS),
        border: isOutlineButton ? Border.fromBorderSide(borderSide) : null,
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
        child: Padding(
          padding: const EdgeInsets.all(DEFAULT_PADDING),
          child: Center(
            child: Text(
              text,
              style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, textColor),
            ),
          ),
        ),
      ),
    );
  }
}
