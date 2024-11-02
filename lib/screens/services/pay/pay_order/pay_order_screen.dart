import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/features/order/bloc/order_bloc.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/format_text.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_bottom_bar.dart';
import '../../../../utils/ui_util/app_text_style.dart';
import '../../../../widgets/common_widgets/dashed_line_painter.dart';
import '../../../mobile/pages/order_page/order_page_mobile_screen.dart';
import '../../invoice/invoice_details/invoice_details_screen.dart';

class PayOrderScreen extends StatefulWidget {
  static const route = "PayOrderScreen";

  const PayOrderScreen({super.key});

  @override
  _PayOrderScreenState createState() => _PayOrderScreenState();
}

class _PayOrderScreenState extends State<PayOrderScreen> {
  final TextEditingController _amountController = TextEditingController();
  Color _selectedPaymentMethod = GREEN_COLOR.withOpacity(0.1);
  String _selectedPaymentMethodLabel = 'Tiền mặt';
  late int totalPrice = 0;
  int enteredAmount = 0;

  @override
  void initState() {
    super.initState();
    totalPrice = context.read<OrderBloc>().totalPrice;
    _amountController.text = FormatText.formatCurrency(totalPrice);
  }

  void _onPaymentMethodSelected(String method, Color color) {
    setState(() {
      _selectedPaymentMethod = color;
      _selectedPaymentMethodLabel = method;
    });
  }

  void _updateEnteredAmount(String value) {
    final cleanValue = value.replaceAll(RegExp(r'[^\d]'), '');
    setState(() {
      enteredAmount = cleanValue.isNotEmpty ? int.parse(cleanValue) : 0;
      _amountController.text = FormatText.formatCurrency(enteredAmount);
      _amountController.selection = TextSelection.fromPosition(
        TextPosition(offset: _amountController.text.length - 1),
      );
    });
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
            MaterialPageRoute(builder: (context) => const InvoiceDetailsScreen()),
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
        backgroundColor: WHITE_COLOR,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.all(DEFAULT_PADDING),
            color: WHITE_COLOR,
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
                  const SizedBox(width: DEFAULT_MARGIN),
                  Text(
                    'Thanh toán ${FormatText.formatCurrency(totalPrice)}',
                    style: AppTextStyle.medium(PLUS_LARGE_TEXT_SIZE),
                  ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: PRIMARY_COLOR),
                      minimumSize: const Size(0, 30),
                      padding: const EdgeInsets.symmetric(
                          horizontal: MEDIUM_PADDING),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(SMALL_BORDER_RADIUS),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Iconsax.user_copy,
                            color: PRIMARY_COLOR, size: 18),
                        const SizedBox(width: DEFAULT_MARGIN),
                        Text(
                          'Thảo Vy',
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: SUPER_LARGE_MARGIN,
            ),
            Text(
              'Khách trả',
              style: AppTextStyle.semibold(LARGE_TEXT_SIZE, GREY_COLOR),
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  TextField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nhập số tiền',
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: _updateEnteredAmount,
                    style: AppTextStyle.semibold(40, PRIMARY_COLOR),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: LARGE_PADDING),
                    child: CustomPaint(
                      size: const Size(double.infinity, 1),
                      painter: DashedLinePainter(
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DEFAULT_MARGIN),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        enteredAmount < totalPrice ? 'Ghi nợ: ' : 'Tiền thừa: ',
                    style: AppTextStyle.medium(LARGE_TEXT_SIZE, GREY_COLOR),
                  ),
                  TextSpan(
                    text: FormatText.formatCurrency(
                      enteredAmount < totalPrice
                          ? totalPrice - enteredAmount
                          : enteredAmount - totalPrice,
                    ),
                    style: AppTextStyle.medium(LARGE_TEXT_SIZE, ORANGE_COLOR),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 1,
                    child: PaymentMethodItem(
                      title: 'Tiền mặt',
                      backgroundColor:
                          _selectedPaymentMethod == GREEN_COLOR.withOpacity(0.1)
                              ? GREEN_COLOR.withOpacity(0.1)
                              : Colors.white,
                      borderColor:
                          _selectedPaymentMethod == GREEN_COLOR.withOpacity(0.1)
                              ? GREEN_COLOR
                              : Colors.grey,
                      textColor:
                          _selectedPaymentMethod == GREEN_COLOR.withOpacity(0.1)
                              ? GREEN_COLOR
                              : Colors.grey,
                      // Set text color based on selection
                      onTap: () => _onPaymentMethodSelected(
                          'Tiền mặt', GREEN_COLOR.withOpacity(0.1)),
                    ),
                  ),
                  const SizedBox(width: DEFAULT_MARGIN),
                  Flexible(
                    flex: 1,
                    child: PaymentMethodItem(
                      title: 'Ví điện tử',
                      backgroundColor: _selectedPaymentMethod ==
                              PRIMARY_COLOR.withOpacity(0.1)
                          ? PRIMARY_COLOR.withOpacity(0.1)
                          : Colors.white,
                      borderColor: _selectedPaymentMethod ==
                              PRIMARY_COLOR.withOpacity(0.1)
                          ? PRIMARY_COLOR
                          : Colors.grey,
                      textColor: _selectedPaymentMethod ==
                              PRIMARY_COLOR.withOpacity(0.1)
                          ? PRIMARY_COLOR
                          : Colors.grey,
                      // Set text color based on selection
                      onTap: () => _onPaymentMethodSelected(
                          'Ví điện tử', PRIMARY_COLOR.withOpacity(0.1)),
                    ),
                  ),
                  const SizedBox(width: DEFAULT_MARGIN),
                  Flexible(
                    flex: 1,
                    child: PaymentMethodItem(
                      title: 'Ngân hàng',
                      backgroundColor: _selectedPaymentMethod ==
                              ORANGE_COLOR.withOpacity(0.1)
                          ? ORANGE_COLOR.withOpacity(0.1)
                          : Colors.white,
                      borderColor: _selectedPaymentMethod ==
                              ORANGE_COLOR.withOpacity(0.1)
                          ? ORANGE_COLOR
                          : Colors.grey,
                      textColor: _selectedPaymentMethod ==
                              ORANGE_COLOR.withOpacity(0.1)
                          ? ORANGE_COLOR
                          : Colors.grey,
                      // Set text color based on selection
                      onTap: () => _onPaymentMethodSelected(
                          'Ngân hàng', ORANGE_COLOR.withOpacity(0.1)),
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
        bottomNavigationBar: CustomBottomBar(
          rightButtonText: 'Xác nhận',
          onRightButtonPressed: () {
            context.read<OrderBloc>().add((UpdateOrderDetailsStarted(
                newPaymentMethod: _selectedPaymentMethodLabel)));
            context.read<OrderBloc>().add(OrderCreateStarted());
          },
        ),
      ),
    );
  }
}

class PaymentMethodItem extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onTap;
  final Color textColor;

  const PaymentMethodItem({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.borderColor,
    required this.onTap,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          title,
          style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, textColor),
        ),
      ),
    );
  }
}
