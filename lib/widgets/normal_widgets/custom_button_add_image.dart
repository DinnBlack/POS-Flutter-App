import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';

import '../../utils/ui_util/app_text_style.dart';

class CustomButtonAddImage extends StatelessWidget {
  final String? title;
  final bool isRequired;

  const CustomButtonAddImage({
    super.key,
    this.title,
    this.isRequired = false,
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
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Chụp ảnh'),
                onTap: () {
                  Navigator.of(context).pop();
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
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Text(
                  title!,
                  style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, GREY_COLOR),
                ),
                if (isRequired)
                  const Text(
                    ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        GestureDetector(
          onTap: () => _showImageDialog(context),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: WHITE_COLOR,
              border: Border.all(color: GREY_LIGHT_COLOR),
              borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
            ),
            child: const Center(
              child: Icon(
                Icons.add_rounded,
                color: GREY_COLOR,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
