import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/features/order/bloc/order_bloc.dart';
import 'package:pos_flutter_app/screens/services/pay/pay_order/pay_order_screen.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/format_text.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_bottom_bar.dart';
import '../../../../utils/ui_util/app_text_style.dart';
import '../../invoice/invoice_details/invoice_details_screen.dart';

class PayOrderBottomSheet extends StatefulWidget {
  const PayOrderBottomSheet({super.key});

  @override
  _PayOrderBottomSheetState createState() => _PayOrderBottomSheetState();
}

class _PayOrderBottomSheetState extends State<PayOrderBottomSheet> {
  final TextEditingController _amountController = TextEditingController();
  Color _selectedPaymentMethod = GREEN_COLOR.withOpacity(0.1);
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
          color: WHITE_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(SMALL_BORDER_RADIUS)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: DEFAULT_MARGIN),
            Stack(
              children: [
                Center(
                  child: Text(
                    'Thanh toán trước',
                    style: AppTextStyle.semibold(LARGE_TEXT_SIZE),
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
            const SizedBox(height: SMALL_MARGIN),
            Divider(color: GREY_LIGHT_COLOR),
            const SizedBox(height: DEFAULT_MARGIN),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        FormatText.formatCurrency(context.read<OrderBloc>().totalPrice),
                        style: AppTextStyle.semibold(40, ORANGE_COLOR),
                      ),
                    ),
                    const SizedBox(height: DEFAULT_MARGIN),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Khách trả',
                        style: AppTextStyle.medium(LARGE_TEXT_SIZE, GREY_COLOR),
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
                        style: AppTextStyle.semibold(PLUS_LARGE_TEXT_SIZE, PRIMARY_COLOR),
                      ),
                    ),
                    Divider(color: GREY_LIGHT_COLOR),
                    const SizedBox(height: DEFAULT_MARGIN),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: enteredAmount < totalPrice
                                ? 'Ghi nợ: '
                                : 'Tiền thừa: ',
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 1,
                    child: PaymentMethodItem(
                      title: 'Tiền mặt',
                      backgroundColor: _selectedPaymentMethod == GREEN_COLOR.withOpacity(0.1)
                          ? GREEN_COLOR.withOpacity(0.1)
                          : Colors.white,
                      borderColor: _selectedPaymentMethod == GREEN_COLOR.withOpacity(0.1)
                          ? GREEN_COLOR
                          : Colors.grey,
                      textColor: _selectedPaymentMethod == GREEN_COLOR.withOpacity(0.1)
                          ? GREEN_COLOR
                          : Colors.grey,
                      onTap: () => _onPaymentMethodSelected('Tiền mặt', GREEN_COLOR.withOpacity(0.1)),
                    ),
                  ),
                  const SizedBox(width: DEFAULT_MARGIN),
                  Flexible(
                    flex: 1,
                    child: PaymentMethodItem(
                      title: 'Ví điện tử',
                      backgroundColor: _selectedPaymentMethod == PRIMARY_COLOR.withOpacity(0.1)
                          ? PRIMARY_COLOR.withOpacity(0.1)
                          : Colors.white,
                      borderColor: _selectedPaymentMethod == PRIMARY_COLOR.withOpacity(0.1)
                          ? PRIMARY_COLOR
                          : Colors.grey,
                      textColor: _selectedPaymentMethod == PRIMARY_COLOR.withOpacity(0.1)
                          ? PRIMARY_COLOR
                          : Colors.grey,
                      onTap: () => _onPaymentMethodSelected('Ví điện tử', PRIMARY_COLOR.withOpacity(0.1)),
                    ),
                  ),
                  const SizedBox(width: DEFAULT_MARGIN),
                  Flexible(
                    flex: 1,
                    child: PaymentMethodItem(
                      title: 'Ngân hàng',
                      backgroundColor: _selectedPaymentMethod == ORANGE_COLOR.withOpacity(0.1)
                          ? ORANGE_COLOR.withOpacity(0.1)
                          : Colors.white,
                      borderColor: _selectedPaymentMethod == ORANGE_COLOR.withOpacity(0.1)
                          ? ORANGE_COLOR
                          : Colors.grey,
                      textColor: _selectedPaymentMethod == ORANGE_COLOR.withOpacity(0.1)
                          ? ORANGE_COLOR
                          : Colors.grey,
                      onTap: () => _onPaymentMethodSelected('Ngân hàng', ORANGE_COLOR.withOpacity(0.1)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DEFAULT_MARGIN),
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
