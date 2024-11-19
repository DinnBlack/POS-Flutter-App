import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';

import '../../utils/app_text_style.dart';

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
        style: AppTextStyle.semibold(kTextSizeMd, kColorWhite),
      ),
      icon: icon ?? const Icon(Icons.add, color: Colors.white),
      backgroundColor: kColorPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(width: 2, color: kColorWhite),
      ),
    );
  }
}
