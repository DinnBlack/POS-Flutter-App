import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import '../../utils/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = color ?? PRIMARY_COLOR;

    return Container(
      height: DEFAULT_HEIGHT,
      width: double.infinity,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
        child: Padding(
          padding: const EdgeInsets.all(DEFAULT_PADDING),
          child: Center(
            child: Text(
              text,
              style: AppTextStyle.medium(LARGE_TEXT_SIZE, WHITE_COLOR),
            ),
          ),
        ),
      ),
    );
  }
}
