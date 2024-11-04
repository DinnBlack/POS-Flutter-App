import 'package:flutter/material.dart';

import '../../utils/constants/constants.dart';
import '../../utils/ui_util/app_text_style.dart';

class CustomFloatingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Icon? icon;
  const CustomFloatingButton({super.key, required this.text, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: Text(
        text,
        style: AppTextStyle.semibold(MEDIUM_TEXT_SIZE, WHITE_COLOR),
      ),
      icon: icon ?? const Icon(Icons.add, color: Colors.white),
      backgroundColor: PRIMARY_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(width: 2, color: WHITE_COLOR),
      ),
    );
  }
}
