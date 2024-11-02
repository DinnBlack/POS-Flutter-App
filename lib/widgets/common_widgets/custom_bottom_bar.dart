import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_button.dart';

class CustomBottomBar extends StatelessWidget {
  final String? leftButtonText;
  final String? rightButtonText;
  final VoidCallback? onLeftButtonPressed;
  final VoidCallback? onRightButtonPressed;
  final bool hasShadow; // New parameter

  const CustomBottomBar({
    Key? key,
    this.leftButtonText,
    this.rightButtonText,
    this.onLeftButtonPressed,
    this.onRightButtonPressed,
    this.hasShadow = true, // Default value is true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DEFAULT_PADDING),
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        boxShadow: hasShadow // Conditional shadow
            ? [
                BoxShadow(
                  color: GREY_COLOR.withOpacity(0.3),
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
                height: SMALL_HEIGHT,
              ),
            ),
            const SizedBox(
              width: DEFAULT_MARGIN,
            ),
          ],
          if (rightButtonText != null) ...[
            Expanded(
              child: CustomButton(
                text: rightButtonText!,
                onPressed: onRightButtonPressed ?? () {},
                height: SMALL_HEIGHT,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
