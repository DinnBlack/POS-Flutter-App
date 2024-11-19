import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';

import '../../../../../core/widgets/normal_widgets/custom_button_apply_promotion.dart';
import '../../../widget/custom_list_order_details_item.dart';

class OrderDetailsPageScreen extends StatelessWidget {
  const OrderDetailsPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kColorWhite,
        border: Border(
          left: BorderSide(width: 1, color: kColorLightGrey),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: kColorWhite,
              border: Border(
                bottom: BorderSide(width: 1, color: kColorLightGrey),
              ),
            ),
            padding: const EdgeInsets.all(kPaddingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Order Details',
                  style: AppTextStyle.medium(kTextSizeMd),
                ),
                Text(
                  'Order number #001',
                  style: AppTextStyle.medium(kTextSizeMd),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(kPaddingMd),
            decoration: BoxDecoration(
              color: kColorWhite,
              border: Border(
                bottom: BorderSide(width: 1, color: kColorLightGrey),
              ),
            ),
            child: DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'Mang đi', child: Text('Mang đi')),
                DropdownMenuItem(value: 'Tại bàn', child: Text('Tại bàn')),
                DropdownMenuItem(value: 'Giao hàng', child: Text('Giao hàng')),
              ],
              onChanged: (value) {},
              decoration: const InputDecoration(
                labelText: 'Chọn trạng thái',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: kColorWhite,
              border: Border(
                top: BorderSide(width: 1, color: kColorLightGrey),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subtotal'),
                          Text('100.000đ'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Discount',
                              style: AppTextStyle.medium(
                                  kTextSizeMd, kColorGreen)),
                          Text('-20.000đ'),
                        ],
                      ),
                      const Text(
                        '_______________________________',
                        style: TextStyle(color: kColorGrey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TOTAL',
                              style: AppTextStyle.medium(kTextSizeMd)),
                          Text('80.000đ',
                              style: AppTextStyle.medium(kTextSizeMd)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomButtonApplyPromotion(
                        text: 'Thêm ưu đãi',
                        onPressed: () {},
                        selectedText: 'Đã thêm ưu đãi',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kColorPrimary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text('Thanh toán',
                        style: AppTextStyle.medium(kTextSizeMd, kColorWhite)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
