import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/screens/services/customer/dialog/chose_customer_dialog.dart';
import 'package:pos_flutter_app/screens/services/pay/pay_order/pay_order_screen.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_bottom_bar.dart';
import 'package:pos_flutter_app/widgets/normal_widgets/custom_list_order_product_item.dart';

import '../../../../features/category/bloc/category_bloc.dart';
import '../../../../features/order/bloc/order_bloc.dart';
import '../../../../features/product/bloc/product_bloc.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/ui_util/app_text_style.dart';
import '../../../../utils/ui_util/format_text.dart';
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

  List<Map<String, dynamic>> selectedDiscounts = [];
  final Set<String> selectedDiscountTypes = {};

  void _addDiscount(String discountType) {
    if (!selectedDiscountTypes.contains(discountType)) {
      setState(() {
        selectedDiscounts.add({
          'type': discountType,
          'amount': 0,
        });
        selectedDiscountTypes.add(discountType);
      });
    }
  }

  void _removeDiscount(int index) {
    setState(() {
      String type = selectedDiscounts[index]['type'];
      selectedDiscounts.removeAt(index);
      selectedDiscountTypes.remove(type);
    });
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
                    context.read<ProductBloc>().add(ProductFilterChanged(
                        context.read<CategoryBloc>().selectedCategory!));
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
                  onPressed: () {},
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
                        'Mang về',
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
                        context.read<ProductBloc>().add(ProductFilterChanged(
                            context.read<CategoryBloc>().selectedCategory!));
                      },
                      text: 'Thêm sản phẩm',
                      icon: Icons.add_rounded,
                    ),
                    const SizedBox(height: DEFAULT_PADDING),
                    BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              context.read<OrderBloc>().orderProductList.length,
                          itemBuilder: (context, index) {
                            final product = context
                                .read<OrderBloc>()
                                .orderProductList[index];

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
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tổng ${BlocProvider.of<OrderBloc>(context).totalProductCount} sản phẩm',
                            style: AppTextStyle.medium(
                                LARGE_TEXT_SIZE, GREY_COLOR),
                          ),
                          Text(
                            FormatText.formatCurrency(
                                BlocProvider.of<OrderBloc>(context).totalPrice),
                            style: AppTextStyle.semibold(LARGE_TEXT_SIZE),
                          ),
                        ],
                      ),
                      ...selectedDiscounts.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> discount = entry.value;
                        return Column(
                          children: [
                            const SizedBox(
                              height: DEFAULT_MARGIN,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  child: const Icon(
                                    Iconsax.close_circle_copy,
                                    color: GREY_COLOR,
                                    size: 20,
                                  ),
                                  onTap: () => _removeDiscount(index),
                                ),
                                const SizedBox(
                                  width: DEFAULT_MARGIN,
                                ),
                                Text(
                                  discount['type'],
                                  style: AppTextStyle.medium(
                                      LARGE_TEXT_SIZE, GREY_COLOR),
                                ),
                                const Spacer(),
                                Text(
                                  FormatText.formatCurrency(discount['amount']),
                                  style: AppTextStyle.medium(
                                      LARGE_TEXT_SIZE, PRIMARY_COLOR),
                                ),
                                const SizedBox(
                                  width: SMALL_MARGIN,
                                ),
                                InkWell(
                                  child: const Icon(
                                    Iconsax.edit_2_copy,
                                    color: PRIMARY_COLOR,
                                    size: 18,
                                  ),
                                  onTap: () => _removeDiscount(index),
                                ),
                              ],
                            ),
                          ],
                        );
                      }).toList(),
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
                            FormatText.formatCurrency(
                                BlocProvider.of<OrderBloc>(context).totalPrice),
                            style: AppTextStyle.semibold(
                                LARGE_TEXT_SIZE, RED_COLOR),
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
                  );
                },
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
                    'Ghi chú',
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
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Ghi chú',
                                    hintStyle: AppTextStyle.medium(
                                        LARGE_TEXT_SIZE, GREY_COLOR),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: GREY_COLOR.withOpacity(0.5)),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: GREY_COLOR),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.image_outlined,
                                  color: GREY_COLOR,
                                ),
                              ),
                            ],
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
                  Text(
                    'Thông tin thêm',
                    style: AppTextStyle.semibold(LARGE_TEXT_SIZE, GREY_COLOR),
                  ),
                  const SizedBox(
                    height: DEFAULT_MARGIN,
                  ),
                  if (selectedDiscountTypes.length < 3)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (!selectedDiscountTypes.contains('Giảm giá'))
                          OutlinedButton(
                            onPressed: () => _addDiscount('Giảm giá'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: PRIMARY_COLOR,
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: PRIMARY_COLOR,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text('Giảm giá'),
                          ),
                        if (!selectedDiscountTypes.contains('Phụ thu'))
                          OutlinedButton(
                            onPressed: () => _addDiscount('Phụ thu'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: PRIMARY_COLOR,
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: PRIMARY_COLOR,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text('Phụ thu'),
                          ),
                        if (!selectedDiscountTypes.contains('Khuyến mãi'))
                          OutlinedButton(
                            onPressed: () => _addDiscount('Khuyến mãi'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: PRIMARY_COLOR,
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: PRIMARY_COLOR,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text('Khuyến mãi'),
                          ),
                      ],
                    ),
                  if (selectedDiscountTypes.length == 3)
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: DEFAULT_PADDING),
                      child: Text(
                        'Bạn đã thêm tất cả thông tin khác của sản phẩm',
                        style: AppTextStyle.medium(
                            MEDIUM_TEXT_SIZE, PRIMARY_COLOR),
                      ),
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
        onLeftButtonPressed: () {},
        onRightButtonPressed: () {
          // context.read<OrderBloc>().add(OrderCreateStarted());
          Navigator.pushNamed(context, PayOrderScreen.route);
        },
      ),
    );
  }
}
