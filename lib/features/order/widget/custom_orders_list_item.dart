import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/features/order/bloc/order_bloc.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';
import 'package:toastification/toastification.dart';
import '../model/order_model.dart';
import '../screen/order_details/order_details_screen.dart';
import '../../../core/utils/format_text.dart';
import '../../../core/widgets/common_widgets/custom_button.dart';
import '../../../core/widgets/common_widgets/dashed_line_painter.dart';
import '../../../core/widgets/common_widgets/toast_helper.dart';

class CustomOrdersListItem extends StatefulWidget {
  final OrderModel order;

  const CustomOrdersListItem({super.key, required this.order});

  @override
  _CustomOrdersListItemState createState() => _CustomOrdersListItemState();
}

class _CustomOrdersListItemState extends State<CustomOrdersListItem> {
  bool _isTapped = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isTapped = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isTapped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(order: widget.order),
          ),
        );
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: _isTapped ? 0.95 : 1.0,
        curve: Curves.easeInOut,
        child: Container(
          padding: const EdgeInsets.all(kPaddingMd),
          decoration: BoxDecoration(
              color: kColorWhite,
              borderRadius: BorderRadius.circular(kBorderRadiusMd),
              border: Border.all(color: kColorLightGrey, width: 1)),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.order.customer!.name,
                          style: AppTextStyle.semibold(kTextSizeLg),
                        ),
                        const SizedBox(height: kMarginSm),
                        Text(
                          '${DateFormat('HH:mm dd/MM').format(widget.order.orderTime!)} - ${widget.order.orderId!}',
                          style: AppTextStyle.medium(kTextSizeMd, kColorGrey),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPaddingMd),
                        decoration: BoxDecoration(
                          color: widget.order.status == 'Đang xử lý'
                              ? Colors.orange.withOpacity(0.2)
                              : widget.order.status == 'Hoàn tất'
                                  ? Colors.green.withOpacity(0.2)
                                  : widget.order.status == 'Hủy'
                                      ? Colors.red.withOpacity(0.2)
                                      : Colors.transparent,
                          borderRadius: BorderRadius.circular(kBorderRadiusMd),
                        ),
                        child: Text(
                          widget.order.status!,
                          style: AppTextStyle.medium(
                            kTextSizeMd,
                            widget.order.status == 'Đang xử lý'
                                ? Colors.orange
                                : widget.order.status == 'Hoàn tất'
                                    ? Colors.green
                                    : widget.order.status == 'Hủy'
                                        ? Colors.red
                                        : kColorGrey,
                          ),
                        ),
                      ),
                      const SizedBox(height: kMarginSm),
                      Text(
                        'Tạo bởi ${widget.order.executor!}',
                        style: AppTextStyle.medium(kTextSizeMd, kColorGrey),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kPaddingMd),
                child: CustomPaint(
                  size: const Size(double.infinity, 1),
                  painter: DashedLinePainter(),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng cộng',
                    style: AppTextStyle.medium(kTextSizeLg),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        FormatText.formatCurrency(widget.order.totalPrice!),
                        style: AppTextStyle.semibold(kTextSizeLg),
                      ),
                      const SizedBox(height: kMarginSm),
                      Text(
                        '${widget.order.paymentStatus}',
                        style: AppTextStyle.medium(
                          kTextSizeMd,
                          widget.order.paymentStatus == 'Đã thanh toán'
                              ? Colors.green
                              : widget.order.paymentStatus ==
                                      'Thanh toán một phần'
                                  ? Colors.orange
                                  : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (widget.order.status == 'Đang xử lý') ...[
                const SizedBox(height: kMarginMd),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: kColorWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(kBorderRadiusMd),
                                ),
                                title: Text(
                                  'Xác nhận hủy đơn hàng',
                                  style: AppTextStyle.semibold(kTextSizeXxl),
                                ),
                                content: Text(
                                  'Bạn có chắc chắn muốn hủy đơn hàng này?',
                                  style: AppTextStyle.medium(kTextSizeLg),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Hủy'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.read<OrderBloc>().add(
                                          UpdateOrderDetailsStarted(
                                              orderId: widget.order.orderId!,
                                              newStatus: 'Hủy'));
                                      ToastHelper.showToast(
                                        context,
                                        'Đơn hàng đã hủy!',
                                        'Thông tin đơn hàng của bạn đã được lưu.',
                                        ToastificationType.error,
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Đồng ý'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        text: 'Hủy bỏ',
                        height: 40,
                        textStyle: AppTextStyle.medium(kTextSizeMd, kColorPrimary),
                        color: kColorPrimary.withOpacity(0.1),
                      ),
                    ),
                    const SizedBox(width: kMarginMd),
                    Expanded(
                      child: CustomButton(
                        color: kColorSecondary,
                        onPressed: () {
                          context.read<OrderBloc>().add(
                              UpdateOrderDetailsStarted(
                                  orderId: widget.order.orderId!,
                                  newStatus: 'Hoàn tất'));
                          ToastHelper.showToast(
                            context,
                            'Đơn hàng đã hoàn tất!',
                            'Thông tin đơn hàng của bạn đã được lưu.',
                            ToastificationType.success,
                          );
                        },
                        text: 'Đã giao',
                        textStyle: AppTextStyle.medium(kTextSizeMd),
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
