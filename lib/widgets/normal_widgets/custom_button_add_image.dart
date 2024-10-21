import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../utils/constants/constants.dart';

class CustomButtonAddImage extends StatelessWidget {
  final bool isRequired;
  final void Function(bool isCamera) onTap;

  const CustomButtonAddImage({
    super.key,
    this.isRequired = false,
    required this.onTap,
  });

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn hành động'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Tải ảnh lên'),
                onTap: () {
                  Navigator.of(context).pop();
                  onTap(false);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Chụp ảnh'),
                onTap: () {
                  Navigator.of(context).pop();
                  onTap(true);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        GestureDetector(
          onTap: () => _showImageDialog(context),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: GREY_LIGHT_COLOR),
              borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
              color: WHITE_COLOR,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.add_copy,
                  color: GREY_COLOR,
                ),
                SizedBox(height: DEFAULT_MARGIN),
                Text(
                  'Chọn ảnh',
                  style: TextStyle(color: GREY_COLOR),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
