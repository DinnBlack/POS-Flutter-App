import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import 'package:pos_flutter_app/utils/ui_util/format_text.dart';
import '../../models/order_model.dart';
import '../../screens/services/order/order_details/order_details_screen.dart';
import '../common_widgets/dashed_line_painter.dart';

class CustomOrdersListItem extends StatelessWidget {
  final OrderModel order;

  const CustomOrdersListItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(order: order),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(DEFAULT_PADDING),
        decoration: BoxDecoration(
          color: WHITE_COLOR,
          borderRadius: BorderRadius.circular(SMALL_BORDER_RADIUS),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: const Offset(0, 1),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.customerName!,
                        style: AppTextStyle.semibold(LARGE_TEXT_SIZE),
                      ),
                      const SizedBox(
                        height: SMALL_MARGIN,
                      ),
                      Text(
                        '${DateFormat('HH:mm dd/MM').format(order.orderTime!)} - ${order.orderId!}',
                        style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, GREY_COLOR),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DEFAULT_PADDING,
                      ),
                      decoration: BoxDecoration(
                        color: order.status == 'Đang xử lý'
                            ? Colors.orange.withOpacity(0.2)
                            : order.status == 'Hoàn tất'
                            ? Colors.green.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
                      ),
                      child: Text(
                        order.status!,
                        style: AppTextStyle.medium(
                          MEDIUM_TEXT_SIZE,
                          order.status == 'Đang xử lý'
                              ? Colors.orange
                              : order.status == 'Hoàn tất'
                              ? Colors.green
                              : GREY_COLOR,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: SMALL_MARGIN,
                    ),
                    Text(
                      'Tạo bởi ${order.executor!}',
                      style: AppTextStyle.medium(LARGE_TEXT_SIZE, GREY_COLOR),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: DEFAULT_PADDING),
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
                  style: AppTextStyle.medium(LARGE_TEXT_SIZE),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      FormatText.formatCurrency(order.totalPrice!),
                      style: AppTextStyle.semibold(LARGE_TEXT_SIZE),
                    ),
                    const SizedBox(
                      height: SMALL_MARGIN,
                    ),
                    Text(
                      order.paymentStatus == true
                          ? 'Đã thanh toán'
                          : 'Chưa thanh toán',
                      style: AppTextStyle.medium(
                        MEDIUM_TEXT_SIZE,
                        order.paymentStatus == true ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
