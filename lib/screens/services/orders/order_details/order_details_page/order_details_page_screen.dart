import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

import '../../../../../database/db_products.dart';
import '../../../../../widgets/normal_widgets/custom_list_order_details_item.dart';
import '../../../../../widgets/normal_widgets/custom_button_apply_promotion.dart';

class OrderDetailsPageScreen extends StatelessWidget {
  const OrderDetailsPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        border: Border(
          left: BorderSide(width: 1, color: GREY_LIGHT_COLOR),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: WHITE_COLOR,
              border: Border(
                bottom: BorderSide(width: 1, color: GREY_LIGHT_COLOR),
              ),
            ),
            padding: const EdgeInsets.all(DEFAULT_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Order Details',
                  style: AppTextStyle.medium(
                      MEDIUM_TEXT_SIZE),
                ),
                Text(
                  'Order number #001',
                  style: AppTextStyle.medium(
                      MEDIUM_TEXT_SIZE),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(DEFAULT_PADDING),
            decoration: BoxDecoration(
              color: WHITE_COLOR,
              border: Border(
                bottom: BorderSide(width: 1, color: GREY_LIGHT_COLOR),
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
          Expanded(
            child: dbProducts.isEmpty
                ? Center(
                    child: Text('Không có sản phẩm được chọn',
                        style: AppTextStyle.medium(
                            MEDIUM_TEXT_SIZE)),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(DEFAULT_PADDING),
                    itemCount: dbProducts.length,
                    separatorBuilder: (context, index) => Text(
                      '----------------------------------------------------',
                      style: TextStyle(color: GREY_LIGHT_COLOR),
                    ),
                    itemBuilder: (context, index) {
                      final product = dbProducts[index];
                      return CustomListOrderDetailsPageItem(
                        product: product,
                      );
                    },
                  ),
          ),
          Container(
            decoration: BoxDecoration(
              color: WHITE_COLOR,
              border: Border(
                top: BorderSide(width: 1, color: GREY_LIGHT_COLOR),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
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
                          Text(
                            'Discount',
                              style: AppTextStyle.medium(
                                  MEDIUM_TEXT_SIZE, GREEN_COLOR)
                          ),
                          Text('-20.000đ'),
                        ],
                      ),
                      const Text(
                        '_______________________________',
                        style: TextStyle(color: GREY_COLOR),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOTAL',
                            style: AppTextStyle.medium(
                                  MEDIUM_TEXT_SIZE)
                          ),
                          Text(
                            '80.000đ',
                            style: AppTextStyle.medium(
                                  MEDIUM_TEXT_SIZE)
                          ),
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
                      backgroundColor: PRIMARY_COLOR,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child:  Text(
                      'Thanh toán',
                        style: AppTextStyle.medium(
                            MEDIUM_TEXT_SIZE, WHITE_COLOR)
                    ),
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
