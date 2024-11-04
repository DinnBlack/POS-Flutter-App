import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_button.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_list_products_item.dart';

import '../../../../models/order_model.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/ui_util/app_text_style.dart';
import '../../../../utils/ui_util/format_text.dart';
import '../../../../widgets/common_widgets/dashed_line_painter.dart';
import '../../../../widgets/normal_widgets/custom_order_progress.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.all(DEFAULT_PADDING),
          color: Colors.white,
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
                  'Chi tiết đơn',
                  style: AppTextStyle.medium(PLUS_LARGE_TEXT_SIZE),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Iconsax.copy_copy,
                    color: BLACK_TEXT_COLOR,
                  ),
                ),
                const SizedBox(width: MEDIUM_MARGIN),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Iconsax.card_remove_1_copy,
                    color: BLACK_TEXT_COLOR,
                  ),
                ),
                const SizedBox(width: MEDIUM_MARGIN),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Iconsax.printer_copy,
                    color: BLACK_TEXT_COLOR,
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
            const SizedBox(height: DEFAULT_MARGIN),
            _GeneralInfo(order: widget.order),
            const SizedBox(height: DEFAULT_MARGIN),
            _CustomerInfo(order: widget.order),
            const SizedBox(height: DEFAULT_MARGIN),
            _ProductsOrderList(order: widget.order),
            const SizedBox(height: DEFAULT_MARGIN),
            _ValueInfo(widget: widget),
            const SizedBox(
              height: DEFAULT_MARGIN,
            ),
            CustomOrderProgress(orderStatus: widget.order.status!,),
          ],
        ),
      ),
    );
  }
}

class _ValueInfo extends StatelessWidget {
  const _ValueInfo({
    super.key,
    required this.widget,
  });

  final OrderDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WHITE_COLOR,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: DEFAULT_PADDING, vertical: MEDIUM_PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng ${widget.order.products!.length} sản phẩm',
                style:
                    AppTextStyle.semibold(MEDIUM_TEXT_SIZE, GREY_COLOR),
              ),
              Text(
                FormatText.formatCurrency(widget.order.totalPrice!),
                style: AppTextStyle.semibold(LARGE_TEXT_SIZE),
              ),
            ],
          ),
          const SizedBox(
            height: DEFAULT_MARGIN,
          ),
          if (widget.order.discount != 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Giảm giá',
                  style:
                      AppTextStyle.medium(MEDIUM_TEXT_SIZE, GREY_COLOR),
                ),
                Text(
                  '- ${FormatText.formatCurrency(widget.order.discount!)}',
                  style: AppTextStyle.medium(LARGE_TEXT_SIZE),
                ),
              ],
            ),
            const SizedBox(height: DEFAULT_MARGIN),
          ],
          if (widget.order.shipping != 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Vận chuyển',
                  style:
                      AppTextStyle.medium(MEDIUM_TEXT_SIZE, GREY_COLOR),
                ),
                Text(
                  '+ ${FormatText.formatCurrency(widget.order.shipping!)}',
                  style: AppTextStyle.medium(LARGE_TEXT_SIZE),
                ),
              ],
            ),
            const SizedBox(height: DEFAULT_MARGIN),
          ],
          if (widget.order.surcharge != 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Phụ thu',
                  style:
                      AppTextStyle.medium(MEDIUM_TEXT_SIZE, GREY_COLOR),
                ),
                Text(
                  '+ ${FormatText.formatCurrency(widget.order.surcharge!)}',
                  style: AppTextStyle.medium(LARGE_TEXT_SIZE),
                ),
              ],
            ),
            const SizedBox(height: DEFAULT_MARGIN),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SMALL_PADDING),
            child: CustomPaint(
              size: const Size(double.infinity, 1),
              painter: DashedLinePainter(),
            ),
          ),
          const SizedBox(height: DEFAULT_MARGIN),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng cộng',
                style: AppTextStyle.semibold(PLUS_LARGE_TEXT_SIZE),
              ),
              Text(
                FormatText.formatCurrency(widget.order.finalTotalPrice),
                style: AppTextStyle.semibold(
                    PLUS_LARGE_TEXT_SIZE, RED_COLOR),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProductsOrderList extends StatelessWidget {
  const _ProductsOrderList({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DEFAULT_PADDING,
        vertical: DEFAULT_PADDING,
      ),
      color: WHITE_COLOR,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: order.products!.length,
        itemBuilder: (context, index) {
          final product = order.products![index];
          return Column(
            children: [
              CustomListProductsItem(
                shouldShowDialog: false,
                product: product,
              ),
              if (index < order.products!.length - 1)
                Divider(
                  color: GREY_LIGHT_COLOR,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _CustomerInfo extends StatelessWidget {
  const _CustomerInfo({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: DEFAULT_PADDING, vertical: MEDIUM_PADDING),
      color: WHITE_COLOR,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: GREY_LIGHT_COLOR,
                width: 1.0,
              ),
            ),
            child: const Center(
              child: Icon(
                Iconsax.user_copy,
                size: 20,
                color: GREEN_COLOR,
              ),
            ),
          ),
          const SizedBox(width: DEFAULT_MARGIN),
          Text(
            order.customerName!,
            style: AppTextStyle.semibold(LARGE_TEXT_SIZE),
          ),
          const SizedBox(width: DEFAULT_MARGIN),
          const Icon(
            Iconsax.copy_copy,
            size: LARGE_TEXT_SIZE,
            color: GREY_COLOR,
          ),
        ],
      ),
    );
  }
}

class _GeneralInfo extends StatelessWidget {
  final OrderModel order;

  const _GeneralInfo({
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: DEFAULT_PADDING, vertical: MEDIUM_PADDING),
      color: WHITE_COLOR,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          order.orderId!,
                          style: AppTextStyle.semibold(LARGE_TEXT_SIZE),
                        ),
                        const SizedBox(width: SMALL_MARGIN),
                        InkWell(
                          child: const Icon(
                            Iconsax.copy_copy,
                            color: GREY_COLOR,
                            size: LARGE_TEXT_SIZE,
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                    const SizedBox(height: SMALL_MARGIN),
                    Text(
                      DateFormat('HH:mm dd/MM').format(order.orderTime!),
                      style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, GREY_COLOR),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                    decoration: BoxDecoration(
                      color: order.status == 'Đang xử lý'
                          ? Colors.orange.withOpacity(0.2)
                          : order.status == 'Hoàn tất'
                              ? Colors.green.withOpacity(0.2)
                              : Colors.transparent,
                      borderRadius:
                          BorderRadius.circular(DEFAULT_BORDER_RADIUS),
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
                  const SizedBox(height: SMALL_MARGIN),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FormatText.formatCurrency(order.finalTotalPrice!),
                    style: AppTextStyle.semibold(SUPER_LARGE_TEXT_SIZE),
                  ),
                  const SizedBox(height: SMALL_MARGIN),
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
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: CustomButton(
                  textSize: SMALL_TEXT_SIZE,
                  text: 'Gửi hóa đơn',
                  onPressed: () {},
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
