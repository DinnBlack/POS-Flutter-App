import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/ui_util/app_colors.dart';

import '../../../../../database/db_products.dart';
import '../../../../../widgets/normal_widgets/custom_list_order_details_item.dart';
import '../../../../../widgets/normal_widgets/custom_button_apply_promotion.dart';

class OrderDetailsPageScreen extends StatelessWidget {
  const OrderDetailsPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          left: BorderSide(width: 1, color: AppColors.grey_02),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(width: 1, color: AppColors.grey_02),
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Order Details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Order number #001',
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(width: 1, color: AppColors.grey_02),
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
                ? const Center(
                    child: Text(
                      'Không có sản phẩm được chọn',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemCount: dbProducts.length,
                    separatorBuilder: (context, index) => Text(
                      '----------------------------------------------------',
                      style: TextStyle(color: AppColors.grey_02),
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
              color: AppColors.white,
              border: Border(
                top: BorderSide(width: 1, color: AppColors.grey_02),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount',
                            style: TextStyle(color: Colors.green),
                          ),
                          Text('-20.000đ'),
                        ],
                      ),
                      const Text(
                        '_______________________________',
                        style: TextStyle(color: AppColors.grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TOTAL',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '80.000đ',
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                      backgroundColor: AppColors.primary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text(
                      'Thanh toán',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
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
