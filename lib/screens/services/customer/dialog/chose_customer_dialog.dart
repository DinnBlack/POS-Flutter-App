import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

class ChoseCustomerDialog extends StatelessWidget {
  const ChoseCustomerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
      ),
      child: Container(
        padding: const EdgeInsets.all(DEFAULT_PADDING),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: DEFAULT_MARGIN),
            TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm khách hàng',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
                ),
              ),
            ),
            const SizedBox(height: DEFAULT_MARGIN),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(DEFAULT_BORDER_RADIUS),
                ),
              ),
              child: const Text('Tạo Mới'),
            ),
            const Divider(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  const Icon(Icons.person, color: PRIMARY_COLOR,),
                  const SizedBox(width: DEFAULT_MARGIN),
                  Text(
                    'Khách Lẻ',
                    style: AppTextStyle.medium(LARGE_TEXT_SIZE, PRIMARY_COLOR),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
