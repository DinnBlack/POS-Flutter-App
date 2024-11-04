import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_bottom_bar.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_text_field.dart';

class CustomerCreateScreen extends StatelessWidget {
  static const route = 'CustomerCreateScreen';

  const CustomerCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: MEDIUM_MARGIN,
            ),
            Stack(
              children: [
                Center(
                  child: Text(
                    'Tạo khách hàng mới',
                    style: AppTextStyle.semibold(LARGE_TEXT_SIZE),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Icon(
                      Icons.close_rounded,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: SUPER_LARGE_MARGIN,
            ),
            _UserAvatarWithCameraIcon(
              onTap: () {},
            ),
            const SizedBox(
              height: MEDIUM_MARGIN,
            ),
            const CustomTextField(
              hintText: 'Ví dụ: Nguyễn Văn A',
              title: 'Tên Khách hàng',
              isRequired: true,
            ),
            const SizedBox(
              height: MEDIUM_MARGIN,
            ),
            const CustomTextField(
              hintText: 'Ví dụ: 0123456789',
              title: 'Số điện thoại',
              isRequired: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        leftButtonText: 'Quay lại',
        rightButtonText: 'Tạo',
        onRightButtonPressed: () {},
        onLeftButtonPressed: () {},
      ),
    );
  }
}

class _UserAvatarWithCameraIcon extends StatelessWidget {
  final VoidCallback onTap;

  const _UserAvatarWithCameraIcon({Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.grey[700],
            ),
          ),
          // Camera Icon Overlay
          Positioned(
            right: 4,
            bottom: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              padding: const EdgeInsets.all(SMALL_PADDING),
              child: const Icon(
                Icons.camera_alt,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
