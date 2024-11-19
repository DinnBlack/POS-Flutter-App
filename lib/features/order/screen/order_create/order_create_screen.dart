import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import '../../../../core/widgets/common_widgets/custom_bottom_bar.dart';
import '../../../../core/widgets/common_widgets/custom_button.dart';
import '../../../../core/widgets/common_widgets/dashed_line_painter.dart';
import '../../../../features/category/bloc/category_bloc.dart';
import '../../../../features/order/bloc/order_bloc.dart';
import '../../../../features/product/bloc/product_bloc.dart';
import '../../../customer/model/customer_model.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/format_text.dart';
import '../../../customer/screen/customer_select/customer_select_screen.dart';
import '../../../invoice/screen/invoice_details/invoice_details_screen.dart';
import '../../../payment/screen/pay_order/pay_order_bottom_sheet.dart';
import '../../../payment/screen/pay_order/pay_order_screen.dart';
import '../../widget/custom_list_order_product_item.dart';

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
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    discountControllers.add(TextEditingController(text: '0đ'));
    focusNodes.add(FocusNode());
    noteController.addListener(_onNoteChanged);
  }

  void _showCustomerDialog(BuildContext context) async {
    final result = await showDialog<CustomerModel>(
      context: context,
      builder: (context) {
        return const CustomerSelectScreen();
      },
    );

    if (result != null) {
      setState(() {
        selectedCustomer = result;
      });
    }
  }

  void _onNoteChanged() {
    final noteText = noteController.text;
    context.read<OrderBloc>().add(
          UpdateOrderDetailsStarted(
            newNote: noteText,
          ),
        );
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
        backgroundColor: kColorBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.all(kPaddingMd),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kColorLightGrey,
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
                      color: kColorBlack,
                    ),
                  ),
                  const SizedBox(
                    width: kMarginMd,
                  ),
                  Text(
                    'Xác nhận',
                    style: AppTextStyle.medium(
                      kTextSizeMd,
                    ),
                  ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: kColorPrimary),
                      minimumSize: const Size(0, 30),
                      padding: const EdgeInsets.symmetric(
                        horizontal: kPaddingMd,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kBorderRadiusMd),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.shopping_cart,
                            color: kColorPrimary, size: 18),
                        const SizedBox(width: kMarginMd),
                        Text(
                          'Mang về',
                          style:
                              AppTextStyle.medium(kTextSizeMd, kColorPrimary),
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
                color: kColorWhite,
                width: double.infinity,
                padding: const EdgeInsets.all(kPaddingMd),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<ProductBloc>().add(ProductFilterChanged(
                              context.read<CategoryBloc>().selectedCategory!));
                        },
                        isOutlineButton: true,
                        text: 'Thêm sản phẩm',
                        icon: Icons.add_rounded,
                      ),
                      const SizedBox(height: kPaddingMd),
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
                                    Divider(color: kColorLightGrey),
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
                height: kMarginMd,
              ),
              Container(
                color: kColorWhite,
                width: double.infinity,
                padding: const EdgeInsets.all(kPaddingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Khách hàng',
                      style: AppTextStyle.semibold(kTextSizeMd, kColorGrey),
                    ),
                    const SizedBox(
                      height: kMarginMd,
                    ),
                    GestureDetector(
                      onTap: () => _showCustomerDialog(context),
                      child: Container(
                        color: kColorWhite,
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
                                      kTextSizeMd, kColorGrey),
                                ),
                                const Icon(
                                  Icons.contacts_outlined,
                                  color: kColorGrey,
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: kColorGrey.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: kMarginMd,
              ),
              Container(
                color: kColorWhite,
                width: double.infinity,
                padding: const EdgeInsets.all(kPaddingMd),
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
                              style:
                                  AppTextStyle.medium(kTextSizeMd, kColorGrey),
                            ),
                            Text(
                              FormatText.formatCurrency(
                                  BlocProvider.of<OrderBloc>(context)
                                      .basePrice),
                              style: AppTextStyle.semibold(kTextSizeMd),
                            ),
                          ],
                        ),
                        ...selectedDiscounts.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, dynamic> discount = entry.value;

                          return Column(
                            children: [
                              const SizedBox(height: kMarginMd),
                              Row(
                                children: [
                                  InkWell(
                                    child: const Icon(
                                      Iconsax.close_circle_copy,
                                      color: kColorGrey,
                                      size: 20,
                                    ),
                                    onTap: () => _removeDiscount(index),
                                  ),
                                  const SizedBox(width: kMarginMd),
                                  Text(
                                    discount['type'],
                                    style: AppTextStyle.medium(
                                        kTextSizeMd, kColorGrey),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    child: TextField(
                                      controller: discountControllers[index],
                                      focusNode: focusNodes[index],
                                      style: AppTextStyle.medium(
                                          kTextSizeMd, kColorPrimary),
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
                                      color: kColorPrimary,
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
                          height: kMarginMd,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: kPaddingMd),
                          child: CustomPaint(
                            size: const Size(double.infinity, 1),
                            painter: DashedLinePainter(),
                          ),
                        ),
                        const SizedBox(
                          height: kMarginMd,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tổng cộng',
                              style: AppTextStyle.semibold(kTextSizeMd),
                            ),
                            Text(
                              FormatText.formatCurrency(
                                  BlocProvider.of<OrderBloc>(context)
                                      .totalPrice),
                              style:
                                  AppTextStyle.semibold(kTextSizeMd, kColorRed),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: kMarginMd,
                        ),
                        BlocBuilder<OrderBloc, OrderState>(
                          builder: (context, state) {
                            if (state is OrderUpdated &&
                                state.updatedOrder.paymentStatus != null &&
                                state.updatedOrder.paidAmount! > 0) {
                              return Column(
                                children: [
                                  Divider(
                                    color: kColorLightGrey,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Trả trước - ${state.updatedOrder.paymentMethod}',
                                        style: AppTextStyle.medium(
                                            kTextSizeMd, kColorGrey),
                                      ),
                                      const Spacer(),
                                      Text(
                                        ' ${FormatText.formatCurrency(state.updatedOrder.paidAmount!)}',
                                        style: AppTextStyle.semibold(
                                          kTextSizeMd,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: kMarginMd,
                                      ),
                                      InkWell(
                                        child: const Icon(
                                          Iconsax.edit_2_copy,
                                          size: 18,
                                          color: kColorPrimary,
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
                              return CustomButton(
                                isOutlineButton: true,
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
                height: kMarginMd,
              ),
              Container(
                color: kColorWhite,
                width: double.infinity,
                padding: const EdgeInsets.all(kPaddingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ghi chú',
                      style: AppTextStyle.semibold(kTextSizeMd, kColorGrey),
                    ),
                    const SizedBox(
                      height: kMarginMd,
                    ),
                    Container(
                      color: kColorWhite,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: noteController,
                                  decoration: InputDecoration(
                                    hintText: 'Ghi chú',
                                    hintStyle: AppTextStyle.medium(
                                        kTextSizeMd, kColorGrey),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: kColorGrey.withOpacity(0.5)),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: kColorGrey),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.image_outlined,
                                  color: kColorGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: kMarginMd,
              ),
              Container(
                color: kColorWhite,
                width: double.infinity,
                padding: const EdgeInsets.all(kPaddingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thông tin thêm',
                      style: AppTextStyle.semibold(kTextSizeMd, kColorGrey),
                    ),
                    const SizedBox(
                      height: kMarginMd,
                    ),
                    if (selectedDiscountTypes.length < 3)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (!selectedDiscountTypes.contains('Giảm giá'))
                            Expanded(
                              child: CustomButton(
                                isOutlineButton: true,
                                text: 'Giảm giá',
                                onPressed: () => _addDiscount('Giảm giá'),
                              ),
                            ),
                          const SizedBox(
                            width: kMarginMd,
                          ),
                          if (!selectedDiscountTypes.contains('Vận chuyển'))
                            Expanded(
                              child: CustomButton(
                                isOutlineButton: true,
                                onPressed: () => _addDiscount('Vận chuyển'),
                                text: 'Vận chuyển',
                              ),
                            ),
                          const SizedBox(
                            width: kMarginMd,
                          ),
                          if (!selectedDiscountTypes.contains('Phụ Thu'))
                            Expanded(
                              child: CustomButton(
                                isOutlineButton: true,
                                onPressed: () => _addDiscount('Phụ Thu'),
                                text: 'Phụ Thu',
                              ),
                            ),
                        ],
                      ),
                    if (selectedDiscountTypes.length == 3)
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: kPaddingMd),
                        child: Text(
                          'Bạn đã thêm tất cả thông tin khác của sản phẩm',
                          style:
                              AppTextStyle.medium(kTextSizeMd, kColorPrimary),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: kMarginMd,
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
            Navigator.pushNamed(context, PayOrderScreen.route);
          },
        ),
      ),
    );
  }
}
