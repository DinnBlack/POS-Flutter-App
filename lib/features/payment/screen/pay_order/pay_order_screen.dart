import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/features/order/bloc/order_bloc.dart';
import 'package:pos_flutter_app/core/utils/format_text.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widgets/custom_bottom_bar.dart';
import '../../../../core/widgets/common_widgets/dashed_line_painter.dart';
import '../../../invoice/screen/invoice_details/invoice_details_screen.dart';

class PayOrderScreen extends StatefulWidget {
  static const route = "PayOrderScreen";

  const PayOrderScreen({super.key});

  @override
  _PayOrderScreenState createState() => _PayOrderScreenState();
}

class _PayOrderScreenState extends State<PayOrderScreen> {
  final TextEditingController _amountController = TextEditingController();
  Color _selectedPaymentMethod = kColorGreen.withOpacity(0.1);
  String _selectedPaymentMethodLabel = 'Tiền mặt';
  late int totalPrice = 0;
  int enteredAmount = 0;

  @override
  void initState() {
    super.initState();
    totalPrice = context.read<OrderBloc>().totalPrice;
    enteredAmount = context.read<OrderBloc>().totalPrice;
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
    // Define the payment status based on enteredAmount and totalPrice
    final paymentStatus = enteredAmount < totalPrice
        ? 'Thanh toán một phần'
        : 'Đã thanh toán';

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
        backgroundColor: kColorWhite,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.all(kPaddingMd),
            color: kColorWhite,
            child: SafeArea(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Iconsax.arrow_left_2_copy,
                      color: kColorBlack,
                    ),
                  ),
                  const SizedBox(width: kMarginMd),
                  Text(
                    'Thanh toán ${FormatText.formatCurrency(totalPrice)}',
                    style: AppTextStyle.medium(kTextSizeLg),
                  ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: kColorPrimary),
                      minimumSize: const Size(0, 30),
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPaddingMd),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kBorderRadiusMd),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Iconsax.user_copy,
                            color: kColorPrimary, size: 18),
                        const SizedBox(width: kMarginMd),
                        Text(
                          'Thảo Vy',
                          style: AppTextStyle.medium(kTextSizeMd, kColorPrimary),
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
            const SizedBox(height: kMarginXxl),
            Text(
              'Khách trả',
              style: AppTextStyle.semibold(kTextSizeLg, kColorGrey),
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
                    style: AppTextStyle.semibold(40, kColorPrimary),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPaddingLg),
                    child: CustomPaint(
                      size: const Size(double.infinity, 1),
                      painter: DashedLinePainter(color: kColorPrimary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kMarginMd),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: enteredAmount < totalPrice ? 'Ghi nợ: ' : 'Tiền thừa: ',
                    style: AppTextStyle.medium(kTextSizeLg, kColorGrey),
                  ),
                  TextSpan(
                    text: FormatText.formatCurrency(
                      enteredAmount < totalPrice
                          ? totalPrice - enteredAmount
                          : enteredAmount - totalPrice,
                    ),
                    style: AppTextStyle.medium(kTextSizeLg, kColorOrange),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 1,
                    child: PaymentMethodItem(
                      title: 'Tiền mặt',
                      backgroundColor:
                      _selectedPaymentMethod == kColorGreen.withOpacity(0.1)
                          ? kColorGreen.withOpacity(0.1)
                          : Colors.white,
                      borderColor: _selectedPaymentMethod == kColorGreen.withOpacity(0.1)
                          ? kColorGreen
                          : Colors.grey,
                      textColor: _selectedPaymentMethod == kColorGreen.withOpacity(0.1)
                          ? kColorGreen
                          : Colors.grey,
                      onTap: () => _onPaymentMethodSelected('Tiền mặt', kColorGreen.withOpacity(0.1)),
                    ),
                  ),
                  const SizedBox(width: kMarginMd),
                  Flexible(
                    flex: 1,
                    child: PaymentMethodItem(
                      title: 'Ví điện tử',
                      backgroundColor: _selectedPaymentMethod == kColorPrimary.withOpacity(0.1)
                          ? kColorPrimary.withOpacity(0.1)
                          : Colors.white,
                      borderColor: _selectedPaymentMethod == kColorPrimary.withOpacity(0.1)
                          ? kColorPrimary
                          : Colors.grey,
                      textColor: _selectedPaymentMethod == kColorPrimary.withOpacity(0.1)
                          ? kColorPrimary
                          : Colors.grey,
                      onTap: () => _onPaymentMethodSelected('Ví điện tử', kColorPrimary.withOpacity(0.1)),
                    ),
                  ),
                  const SizedBox(width: kMarginMd),
                  Flexible(
                    flex: 1,
                    child: PaymentMethodItem(
                      title: 'Ngân hàng',
                      backgroundColor: _selectedPaymentMethod == kColorOrange.withOpacity(0.1)
                          ? kColorOrange.withOpacity(0.1)
                          : Colors.white,
                      borderColor: _selectedPaymentMethod == kColorOrange.withOpacity(0.1)
                          ? kColorOrange
                          : Colors.grey,
                      textColor: _selectedPaymentMethod == kColorOrange.withOpacity(0.1)
                          ? kColorOrange
                          : Colors.grey,
                      onTap: () => _onPaymentMethodSelected('Ngân hàng', kColorOrange.withOpacity(0.1)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kMarginMd),
          ],
        ),
        bottomNavigationBar: CustomBottomBar(
          rightButtonText: 'Xác nhận',
          onRightButtonPressed: () {
            // Trigger the event with payment status
            context.read<OrderBloc>().add(UpdateOrderDetailsStarted(
              newPaymentMethod: _selectedPaymentMethodLabel,
              newPaymentStatus: paymentStatus,
              newPaidAmount: enteredAmount,

            ));
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
          style: AppTextStyle.medium(kTextSizeMd, textColor),
        ),
      ),
    );
  }
}
