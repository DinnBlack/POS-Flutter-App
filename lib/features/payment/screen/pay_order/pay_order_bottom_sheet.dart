import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:pos_flutter_app/features/payment/screen/pay_order/pay_order_screen.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widgets/custom_bottom_bar.dart';
import '../../../invoice/screen/invoice_details/invoice_details_screen.dart';

class PayOrderBottomSheet extends StatefulWidget {
  const PayOrderBottomSheet({super.key});

  @override
  _PayOrderBottomSheetState createState() => _PayOrderBottomSheetState();
}

class _PayOrderBottomSheetState extends State<PayOrderBottomSheet> {
  final TextEditingController _amountController = TextEditingController();
  Color _selectedPaymentMethod = kColorGreen.withOpacity(0.1);
  String _selectedPaymentMethodLabel = 'Tiền mặt';
  late int totalPrice = 0;
  int enteredAmount = 0;

  @override
  void initState() {
    super.initState();
    totalPrice = context.read<OrderBloc>().totalPrice;
    enteredAmount = totalPrice;
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
        TextPosition(offset: _amountController.text.length),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderCreateInProgress) {
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
      child: Container(
        decoration: const BoxDecoration(
          color: kColorWhite,
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadiusMd)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kMarginMd),
            Stack(
              children: [
                Center(
                  child: Text(
                    'Thanh toán trước',
                    style: AppTextStyle.semibold(kTextSizeLg),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: const Icon(Icons.close_rounded),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: kMarginMd),
            Divider(color: kColorLightGrey),
            const SizedBox(height: kMarginMd),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        FormatText.formatCurrency(context.read<OrderBloc>().totalPrice),
                        style: AppTextStyle.semibold(40, kColorOrange),
                      ),
                    ),
                    const SizedBox(height: kMarginMd),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Khách trả',
                        style: AppTextStyle.medium(kTextSizeLg, kColorGrey),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập số tiền',
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.start,
                        onChanged: _updateEnteredAmount,
                        style: AppTextStyle.semibold(kTextSizeLg, kColorPrimary),
                      ),
                    ),
                    Divider(color: kColorLightGrey),
                    const SizedBox(height: kMarginMd),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: enteredAmount < totalPrice
                                ? 'Ghi nợ: '
                                : 'Tiền thừa: ',
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 1,
                    child: PaymentMethodItem(
                      title: 'Tiền mặt',
                      backgroundColor: _selectedPaymentMethod == kColorGreen.withOpacity(0.1)
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
            CustomBottomBar(
              rightButtonText: 'Xác nhận',
              onRightButtonPressed: () {
                final paymentStatus = enteredAmount < totalPrice
                    ? 'Thanh toán một phần'
                    : 'Đã thanh toán';

                context.read<OrderBloc>().add(PrePaymentStarted(
                  paymentStatus: paymentStatus,
                  paidAmount: enteredAmount,
                  paymentMethod: _selectedPaymentMethodLabel,
                ));

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
