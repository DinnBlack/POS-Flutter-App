import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

class CustomToggleOrderStatus extends StatefulWidget {
  const CustomToggleOrderStatus({super.key});

  @override
  State<CustomToggleOrderStatus> createState() =>
      _CustomToggleOrderStatusState();
}

class _CustomToggleOrderStatusState extends State<CustomToggleOrderStatus> {
  bool _isOpen = true;

  void _toggleOrderStatus() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        borderRadius: BorderRadius.circular(LARGE_BORDER_RADIUS),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: _isOpen
                  ? GREEN_COLOR.withOpacity(0.04)
                  : RED_COLOR.withOpacity(0.04),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Iconsax.omega_circle_copy,
                color: _isOpen ? GREEN_COLOR : RED_COLOR,
              ),
              onPressed: _toggleOrderStatus,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            _isOpen ? 'Open Order' : 'Close Order',
            style: AppTextStyle.medium(
              MEDIUM_TEXT_SIZE,
               _isOpen ? GREEN_COLOR : RED_COLOR,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
