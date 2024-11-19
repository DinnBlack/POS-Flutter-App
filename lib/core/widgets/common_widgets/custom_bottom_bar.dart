import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';

import 'custom_button.dart';

class CustomBottomBar extends StatelessWidget {
  final String? leftButtonText;
  final String? rightButtonText;
  final VoidCallback? onLeftButtonPressed;
  final VoidCallback? onRightButtonPressed;
  final bool hasShadow;

  const CustomBottomBar({
    Key? key,
    this.leftButtonText,
    this.rightButtonText,
    this.onLeftButtonPressed,
    this.onRightButtonPressed,
    this.hasShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kPaddingMd),
      decoration: BoxDecoration(
        color: kColorWhite,
        boxShadow: hasShadow // Conditional shadow
            ? [
                BoxShadow(
                  color: kColorLightGrey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -1),
                ),
              ]
            : [], // No shadow if hasShadow is false
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (leftButtonText != null) ...[
            Expanded(
              child: CustomButton(
                isOutlineButton: true,
                text: leftButtonText!,
                onPressed: onLeftButtonPressed ?? () {},
                height: kHeightSm,
              ),
            ),
            const SizedBox(
              width: kMarginMd,
            ),
          ],
          if (rightButtonText != null) ...[
            Expanded(
              child: CustomButton(
                text: rightButtonText!,
                onPressed: onRightButtonPressed ?? () {},
                height: kHeightSm,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
