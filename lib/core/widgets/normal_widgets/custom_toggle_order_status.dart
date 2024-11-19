import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';

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
      padding: const EdgeInsets.all(kPaddingSm),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(kBorderRadiusMd),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: _isOpen
                  ? kColorGreen.withOpacity(0.04)
                  : kColorRed.withOpacity(0.04),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Iconsax.omega_circle_copy,
                color: _isOpen ? kColorGreen : kColorRed,
              ),
              onPressed: _toggleOrderStatus,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            _isOpen ? 'Open Order' : 'Close Order',
            style: AppTextStyle.medium(
              kTextSizeMd,
               _isOpen ? kColorGreen : kColorRed,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
