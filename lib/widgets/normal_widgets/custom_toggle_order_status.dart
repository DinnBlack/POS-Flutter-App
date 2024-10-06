import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/utils/ui_util/app_colors.dart';

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
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: _isOpen
                  ? Colors.green.withOpacity(0.04)
                  : Colors.red.withOpacity(0.04),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Iconsax.omega_circle_copy,
                color: _isOpen ? Colors.green : Colors.red,
              ),
              onPressed: _toggleOrderStatus,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            _isOpen ? 'Open Order' : 'Close Order',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _isOpen ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
