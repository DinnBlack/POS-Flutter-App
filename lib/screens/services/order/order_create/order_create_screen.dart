import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/screens/services/pay/pay_order/pay_order_screen.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_bottom_bar.dart';
import 'package:pos_flutter_app/widgets/normal_widgets/custom_list_order_product_item.dart';

import '../../../../features/category/bloc/category_bloc.dart';
import '../../../../features/order/bloc/order_bloc.dart';
import '../../../../features/product/bloc/product_bloc.dart';
import '../../../../models/customer_model.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/ui_util/app_text_style.dart';
import '../../../../utils/ui_util/format_text.dart';
import '../../../../widgets/common_widgets/custom_outline_button.dart';
import '../../../../widgets/common_widgets/dashed_line_painter.dart';
import '../../customer/customer_select/customer_select_dialog.dart';
import '../../invoice/invoice_details/invoice_details_screen.dart';
import '../../pay/pay_order/pay_order_bottom_sheet.dart';

class OrderCreateScreen extends StatefulWidget {
  static const route = 'OrderCreateScreen';

  const OrderCreateScreen({super.key});

  @override
  State<OrderCreateScreen> createState() => _OrderCreateScreenState();
}

class _OrderCreateScreenState extends State<OrderCreateScreen> {
  CustomerModel? selectedCustomer;
  List<Map<String, dynamic>> selectedDiscounts = [];
  final Set<String> selectedDiscountTypes = {};
  List<TextEditingController> discountControllers = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    discountControllers.add(TextEditingController(text: '0đ'));
    focusNodes.add(FocusNode());
  }

  void _showCustomerDialog(BuildContext context) async {
    final result = await showDialog<CustomerModel>(
      context: context,
      builder: (context) {
        return const CustomerSelectDialog();
      },
    );

    if (result != null) {
      setState(() {
        selectedCustomer = result;
      });
    }
  }

  void _onDiscountChanged(int index, String newValue) {
    if (index < selectedDiscounts.length) {
      setState(() {
        String cleanValue = newValue.replaceAll(RegExp(r'\D'), '');
        int amount = int.tryParse(cleanValue) ?? 0;
        selectedDiscounts[index]['amount'] = amount;
        String formattedValue = formatCurrency(amount);
        discountControllers[index].text = formattedValue;
        discountControllers[index].selection = TextSelection.collapsed(
          offset: formattedValue.length - 1,
        );
        if (index == 0) {
          context.read<OrderBloc>().add(
            UpdateOrderDetailsStarted(
              newDiscount: amount,
              newShipping: selectedDiscounts.length > 1
                  ? selectedDiscounts[1]['amount']
                  : 0,
              newSurcharge: selectedDiscounts.length > 2
                  ? selectedDiscounts[2]['amount']
                  : 0,
            ),
          );
        } else if (index == 1) {
          context.read<OrderBloc>().add(
            UpdateOrderDetailsStarted(
              newDiscount: selectedDiscounts.length > 0
                  ? selectedDiscounts[0]['amount']
                  : 0,
              newShipping: amount,
              newSurcharge: selectedDiscounts.length > 2
                  ? selectedDiscounts[2]['amount']
                  : 0,
            ),
          );
        } else if (index == 2) {
          context.read<OrderBloc>().add(
            UpdateOrderDetailsStarted(
              newDiscount: selectedDiscounts.length > 0
                  ? selectedDiscounts[0]['amount']
                  : 0,
              newShipping: selectedDiscounts.length > 1
                  ? selectedDiscounts[1]['amount']
                  : 0,
              newSurcharge: amount,
            ),
          );
        }
      });
    }
  }


  void _addDiscount(String discountType) {
    if (!selectedDiscountTypes.contains(discountType)) {
      setState(() {
        selectedDiscounts.add({
          'type': discountType,
          'amount': 0,
        });
        selectedDiscountTypes.add(discountType);

        discountControllers.add(TextEditingController(text: '0đ'));
        focusNodes.add(FocusNode());
      });
    }
  }

  void _removeDiscount(int index) {
    if (index < selectedDiscounts.length) {
      setState(() {
        String type = selectedDiscounts[index]['type'];
        selectedDiscounts[index]['amount'] = 0;
        selectedDiscounts.removeAt(index);
        selectedDiscountTypes.remove(type);
        discountControllers.removeAt(index);
        focusNodes.removeAt(index);
      });

      context.read<OrderBloc>().add(
            UpdateOrderDetailsStarted(
              newDiscount: selectedDiscounts.isNotEmpty &&
                      selectedDiscounts[0]['type'] == 'Giảm giá'
                  ? selectedDiscounts[0]['amount']
                  : 0,
              newShipping: selectedDiscounts.isNotEmpty &&
                      selectedDiscounts[1]['type'] == 'Vận chuyển'
                  ? selectedDiscounts[1]['amount']
                  : 0,
              newSurcharge: selectedDiscounts.isNotEmpty &&
                      selectedDiscounts[2]['type'] == 'Phụ phí'
                  ? selectedDiscounts[2]['amount']
                  : 0,
            ),
          );
    } else {
      print("Chỉ mục không hợp lệ hoặc danh sách trống.");
    }
  }

  String formatCurrency(int amount) {
    final formatted = amount.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'), (Match m) => '${m[0]}.');

    return '$formattedđ';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderCreateInProgress) {
          // Show loading dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return const Center(child: CircularProgressIndicator());
            },
          );
        } else if (state is OrderCreateSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const InvoiceDetailsScreen()),
          );
        } else if (state is OrderCreateFailure) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(state.error),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Scaffold(
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
                            itemCount: context
                                .read<OrderBloc>()
                                .orderProductList
                                .length,
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
                                  selectedCustomer != null
                                      ? selectedCustomer!.name
                                      : 'Chọn khách hàng',
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
                                  BlocProvider.of<OrderBloc>(context)
                                      .basePrice),
                              style: AppTextStyle.semibold(LARGE_TEXT_SIZE),
                            ),
                          ],
                        ),
                        ...selectedDiscounts.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, dynamic> discount = entry.value;

                          return Column(
                            children: [
                              const SizedBox(height: DEFAULT_MARGIN),
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
                                  const SizedBox(width: DEFAULT_MARGIN),
                                  Text(
                                    discount['type'],
                                    style: AppTextStyle.medium(
                                        LARGE_TEXT_SIZE, GREY_COLOR),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    child: TextField(
                                      controller: discountControllers[index],
                                      focusNode: focusNodes[index],
                                      style: AppTextStyle.medium(
                                          LARGE_TEXT_SIZE, PRIMARY_COLOR),
                                      keyboardType: TextInputType.number,
                                      onChanged: (text) {
                                        _onDiscountChanged(index, text);
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Nhập số tiền',
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  InkWell(
                                    child: const Icon(
                                      Icons.edit_note_outlined,
                                      size: 16,
                                      color: PRIMARY_COLOR,
                                    ),
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(focusNodes[index]);
                                      TextEditingController controller =
                                          discountControllers[index];

                                      controller.selection =
                                          TextSelection.fromPosition(
                                        TextPosition(
                                            offset: controller.text.length - 1),
                                      );
                                    },
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
                          padding: const EdgeInsets.symmetric(
                              vertical: SMALL_PADDING),
                          child: CustomPaint(
                            size: const Size(double.infinity, 1),
                            painter: DashedLinePainter(),
                          ),
                        ),
                        const SizedBox(
                          height: DEFAULT_MARGIN,
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
                                  BlocProvider.of<OrderBloc>(context)
                                      .totalPrice),
                              style: AppTextStyle.semibold(
                                  LARGE_TEXT_SIZE, RED_COLOR),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: DEFAULT_MARGIN,
                        ),
                        BlocBuilder<OrderBloc, OrderState>(
                          builder: (context, state) {
                            if (state is OrderUpdated &&
                                state.updatedOrder.paymentStatus != null &&
                                state.updatedOrder.paidAmount! > 0) {
                              return Column(
                                children: [
                                  Divider(
                                    color: GREY_LIGHT_COLOR,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Trả trước - ${state.updatedOrder.paymentMethod}',
                                        style: AppTextStyle.medium(
                                            MEDIUM_TEXT_SIZE, GREY_COLOR),
                                      ),
                                      const Spacer(),
                                      Text(
                                        ' ${FormatText.formatCurrency(state.updatedOrder.paidAmount!)}',
                                        style: AppTextStyle.semibold(
                                          MEDIUM_TEXT_SIZE,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: DEFAULT_MARGIN,
                                      ),
                                      InkWell(
                                        child: const Icon(
                                          Iconsax.edit_2_copy,
                                          size: 18,
                                          color: PRIMARY_COLOR,
                                        ),
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                const PayOrderBottomSheet(),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return CustomOutlineButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        const PayOrderBottomSheet(),
                                  );
                                },
                                text: 'Thanh toán trước',
                                icon: Icons.wallet_outlined,
                              );
                            }
                          },
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
                                        borderSide:
                                            BorderSide(color: GREY_COLOR),
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
                            Expanded(
                              child: CustomOutlineButton(
                                text: 'Giảm giá',
                                onPressed: () => _addDiscount('Giảm giá'),
                              ),
                            ),
                          const SizedBox(
                            width: SMALL_MARGIN,
                          ),
                          if (!selectedDiscountTypes.contains('Vận chuyển'))
                            Expanded(
                              child: CustomOutlineButton(
                                onPressed: () => _addDiscount('Vận chuyển'),
                                text: 'Vận chuyển',
                              ),
                            ),
                          const SizedBox(
                            width: SMALL_MARGIN,
                          ),
                          if (!selectedDiscountTypes.contains('Phụ Thu'))
                            Expanded(
                              child: CustomOutlineButton(
                                onPressed: () => _addDiscount('Phụ Thu'),
                                text: 'Phụ Thu',
                              ),
                            ),
                        ],
                      ),
                    if (selectedDiscountTypes.length == 3)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: DEFAULT_PADDING),
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
          onLeftButtonPressed: () {
            context.read<OrderBloc>().add(OrderCreateStarted());
          },
          onRightButtonPressed: () {
            // context.read<OrderBloc>().add(OrderCreateStarted());
            Navigator.pushNamed(context, PayOrderScreen.route);
          },
        ),
      ),
    );
  }
}
