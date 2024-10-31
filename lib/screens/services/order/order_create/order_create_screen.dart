import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/screens/services/customer/dialog/chose_customer_dialog.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_bottom_bar.dart';
import 'package:pos_flutter_app/widgets/normal_widgets/custom_list_order_product_item.dart';

import '../../../../features/order/bloc/order_bloc.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/ui_util/app_text_style.dart';
import '../../../../widgets/common_widgets/custom_outline_button.dart';
import '../../../../widgets/common_widgets/dashed_line_painter.dart';

class OrderCreateScreen extends StatefulWidget {
  static const route = 'OrderCreateScreen';

  const OrderCreateScreen({super.key});

  @override
  State<OrderCreateScreen> createState() => _OrderCreateScreenState();
}

class _OrderCreateScreenState extends State<OrderCreateScreen> {
  void _showCustomerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const ChoseCustomerDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.all(DEFAULT_PADDING),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: GREY_LIGHT_COLOR,
                offset: const Offset(0, 1),
                blurRadius: 1,
                spreadRadius: 1,
              ),
            ],
            color: Colors.white,
          ),
          child: SafeArea(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Iconsax.arrow_left_2_copy,
                    color: BLACK_TEXT_COLOR,
                  ),
                ),
                const SizedBox(
                  width: DEFAULT_MARGIN,
                ),
                Text(
                  'Xác nhận',
                  style: AppTextStyle.medium(
                    PLUS_LARGE_TEXT_SIZE,
                  ),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () {
                    // Xử lý sự kiện khi nhấn nút
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: PRIMARY_COLOR),
                    minimumSize: const Size(0, 30),
                    padding: const EdgeInsets.symmetric(
                      horizontal: MEDIUM_PADDING,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(DEFAULT_BORDER_RADIUS),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.shopping_cart,
                          color: PRIMARY_COLOR, size: 18),
                      const SizedBox(width: DEFAULT_MARGIN),
                      Text(
                        'Mang về', // Văn bản
                        style: AppTextStyle.medium(
                            MEDIUM_TEXT_SIZE, PRIMARY_COLOR),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: WHITE_COLOR,
              width: double.infinity,
              padding: const EdgeInsets.all(DEFAULT_PADDING),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomOutlineButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'Thêm sản phẩm',
                      icon: Icons.add_rounded,
                    ),
                    const SizedBox(height: DEFAULT_PADDING),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          context.read<OrderBloc>().orderProductList.length,
                      itemBuilder: (context, index) {
                        final product =
                            context.read<OrderBloc>().orderProductList[index];

                        return Column(
                          children: [
                            CustomListOrderProductItem(product: product),
                            if (index <
                                context
                                        .read<OrderBloc>()
                                        .orderProductList
                                        .length -
                                    1)
                              Divider(color: GREY_LIGHT_COLOR),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: DEFAULT_MARGIN,
            ),
            Container(
              color: WHITE_COLOR,
              width: double.infinity,
              padding: const EdgeInsets.all(DEFAULT_PADDING),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Khách hàng',
                    style: AppTextStyle.semibold(LARGE_TEXT_SIZE, GREY_COLOR),
                  ),
                  const SizedBox(
                    height: DEFAULT_MARGIN,
                  ),
                  GestureDetector(
                    onTap: () => _showCustomerDialog(context),
                    child: Container(
                      color: WHITE_COLOR,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Chọn khách hàng',
                                style: AppTextStyle.medium(
                                    LARGE_TEXT_SIZE, GREY_COLOR),
                              ),
                              Spacer(),
                              const Icon(
                                Icons.contacts_outlined,
                                color: GREY_COLOR,
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: GREY_COLOR.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: DEFAULT_MARGIN,
            ),
            Container(
              color: WHITE_COLOR,
              width: double.infinity,
              padding: const EdgeInsets.all(DEFAULT_PADDING),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng 7 sản phẩm',
                        style: AppTextStyle.medium(LARGE_TEXT_SIZE, GREY_COLOR),
                      ),
                      Text(
                        '18.000đ',
                        style: AppTextStyle.semibold(LARGE_TEXT_SIZE),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: DEFAULT_MARGIN,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: SMALL_PADDING),
                    child: CustomPaint(
                      size: const Size(double.infinity, 1),
                      painter: DashedLinePainter(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng cộng',
                        style: AppTextStyle.semibold(LARGE_TEXT_SIZE),
                      ),
                      Text(
                        '18.000đ',
                        style:
                            AppTextStyle.semibold(LARGE_TEXT_SIZE, RED_COLOR),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: DEFAULT_MARGIN,
                  ),
                  CustomOutlineButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Thanh toán trước',
                    icon: Icons.wallet_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: DEFAULT_MARGIN,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        leftButtonText: 'Lưu đơn',
        rightButtonText: 'Thanh toán',
        onLeftButtonPressed: () {

        },
        onRightButtonPressed: () {

        },
      ),
    );
  }
}
