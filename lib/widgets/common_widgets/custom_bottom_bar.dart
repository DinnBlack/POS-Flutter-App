import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_button.dart';

class CustomBottomBar extends StatelessWidget {
  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback onLeftButtonPressed;
  final VoidCallback onRightButtonPressed;

  const CustomBottomBar({
    Key? key,
    required this.leftButtonText,
    required this.rightButtonText,
    required this.onLeftButtonPressed,
    required this.onRightButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DEFAULT_PADDING),
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        boxShadow: [
          BoxShadow(
            color: GREY_COLOR.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomButton(
              isOutlineButton: true,
              text: leftButtonText,
              onPressed: onLeftButtonPressed,
              height: SMALL_HEIGHT,
            ),
          ),
          const SizedBox(
            width: DEFAULT_MARGIN,
          ),
          Expanded(
            child: CustomButton(
              text: rightButtonText,
              onPressed: onRightButtonPressed,
              height: SMALL_HEIGHT,
            ),
          ),
        ],
      ),
    );
  }
}
