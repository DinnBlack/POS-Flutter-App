import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widgets/custom_button.dart';
import '../../../../screens/mobile/pages/order_page/order_page_mobile_screen.dart';

class EmptyOrderListScreen extends StatelessWidget {
  const EmptyOrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kPaddingMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.assignment_late,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              'Hiện tại không có đơn hàng nào',
              style: AppTextStyle.medium(kTextSizeMd, kColorGrey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, OrderPageMobileScreen.route);
                },
                text: 'Tạo đơn hàng',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
