import 'package:flutter/material.dart';

import '../../utils/constants/constants.dart';
import '../../utils/ui_util/app_text_style.dart';

class CustomOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;

  const CustomOutlineButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: PRIMARY_COLOR),
        minimumSize: const Size(double.infinity, 40),
        padding: const EdgeInsets.symmetric(horizontal: MEDIUM_PADDING),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SMALL_BORDER_RADIUS),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: PRIMARY_COLOR, size: 18),
          const SizedBox(width: DEFAULT_MARGIN),
          Text(
            text,
            style: AppTextStyle.medium(LARGE_TEXT_SIZE, PRIMARY_COLOR),
          ),
        ],
      ),
    );
  }
}
