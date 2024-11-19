import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';

import '../../../../core/utils/format_text.dart';
import '../../../../core/widgets/common_widgets/custom_app_bar.dart';
import '../../../../core/widgets/common_widgets/custom_button.dart';
import '../../../product/widget/custom_list_products_item.dart';
import '../../../../core/widgets/common_widgets/dashed_line_painter.dart';
import '../../widget/custom_order_progress.dart';
import '../../model/order_model.dart';
import '../../../../core/utils/app_text_style.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const route = 'OrderDetailsScreen';
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
      backgroundColor: kColorBackground,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kMarginMd),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
              child: Text(
                'Thông tin cơ bản',
                style: AppTextStyle.medium(kTextSizeMd),
              ),
            ),
            const SizedBox(height: kMarginMd),
            _GeneralInfo(order: widget.order),
            const SizedBox(height: kMarginLg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
              child: Text(
                'Sản phẩm',
                style: AppTextStyle.medium(kTextSizeMd),
              ),
            ),
            const SizedBox(height: kMarginMd),
            _ProductsOrderList(order: widget.order),
            const SizedBox(height: kMarginLg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
              child: Text(
                'Thanh toán',
                style: AppTextStyle.medium(kTextSizeMd),
              ),
            ),
            const SizedBox(height: kMarginMd),
            _ValueInfo(widget: widget),
            const SizedBox(
              height: kMarginLg,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
              child: Text(
                'Trạng thái đơn hàng',
                style: AppTextStyle.medium(kTextSizeMd),
              ),
            ),
            const SizedBox(height: kMarginMd),
            _OrderProgress(),
            const SizedBox(height: kMarginLg),
          ],
        ),
      ),
    );
  }

  Container _OrderProgress() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadiusLg),
        border: Border.all(
          color: kColorLightGrey,
          width: 1.0,
        ),
      ),
      child: CustomOrderProgress(
        orderStatus: widget.order.status!,
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      backgroundColor: kColorBackground,
      isTitleCenter: false,
      leading: const Icon(FontAwesomeIcons.arrowLeft),
      title: 'Chi tiết đơn',
      titleStyle: AppTextStyle.medium(kTextSizeLg),
      actions: [
        InkWell(
          onTap: () {},
          child: const FaIcon(FontAwesomeIcons.search),
        ),
        InkWell(
          onTap: () {},
          child: const FaIcon(FontAwesomeIcons.ellipsis),
        ),
      ],
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadiusLg),
        border: Border.all(
          color: kColorLightGrey,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(kPaddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng ${widget.order.products!.length} sản phẩm',
                style: AppTextStyle.medium(kTextSizeMd, kColorGrey),
              ),
              Text(
                FormatText.formatCurrency(widget.order.totalPrice!),
                style: AppTextStyle.semibold(kTextSizeMd),
              ),
            ],
          ),
          const SizedBox(
            height: kMarginMd,
          ),
          if (widget.order.discount != 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Giảm giá',
                  style: AppTextStyle.medium(kTextSizeMd, kColorGrey),
                ),
                Text(
                  '- ${FormatText.formatCurrency(widget.order.discount!)}',
                  style: AppTextStyle.medium(kTextSizeMd),
                ),
              ],
            ),
            const SizedBox(height: kMarginMd),
          ],
          if (widget.order.shipping != 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Vận chuyển',
                  style: AppTextStyle.medium(kTextSizeMd, kColorGrey),
                ),
                Text(
                  '+ ${FormatText.formatCurrency(widget.order.shipping!)}',
                  style: AppTextStyle.medium(kTextSizeMd),
                ),
              ],
            ),
            const SizedBox(height: kMarginMd),
          ],
          if (widget.order.surcharge != 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Phụ thu',
                  style: AppTextStyle.medium(kTextSizeMd, kColorGrey),
                ),
                Text(
                  '+ ${FormatText.formatCurrency(widget.order.surcharge!)}',
                  style: AppTextStyle.medium(kTextSizeMd),
                ),
              ],
            ),
            const SizedBox(height: kMarginMd),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kPaddingSm),
            child: CustomPaint(
              size: const Size(double.infinity, 1),
              painter: DashedLinePainter(),
            ),
          ),
          const SizedBox(height: kMarginMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng cộng',
                style: AppTextStyle.semibold(kTextSizeLg),
              ),
              Text(
                FormatText.formatCurrency(widget.order.totalPrice!),
                style: AppTextStyle.semibold(kTextSizeLg, kColorRed),
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
      padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadiusLg),
        border: Border.all(
          color: kColorLightGrey,
          width: 1.0,
        ),
      ),
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
                showQuantityCount: false,
                product: product,
              ),
              if (index < order.products!.length - 1)
                CustomPaint(
                  size: const Size(double.infinity, 1),
                  painter: DashedLinePainter(),
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
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: kColorLightGrey,
              width: 1.0,
            ),
          ),
          child: const Center(
            child: Icon(
              Iconsax.user_copy,
              size: 20,
              color: kColorGreen,
            ),
          ),
        ),
        const SizedBox(width: kMarginMd),
        Text(
          order.customer!.name,
          style: AppTextStyle.semibold(kTextSizeMd),
        ),
        const SizedBox(width: kMarginMd),
        const Icon(
          Iconsax.copy_copy,
          size: kTextSizeMd,
          color: kColorGrey,
        ),
      ],
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
      padding: const EdgeInsets.all(kPaddingMd),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadiusLg),
        border: Border.all(
          color: kColorLightGrey,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                order.orderId!,
                style: AppTextStyle.semibold(kTextSizeLg),
              ),
              const SizedBox(width: kMarginMd),
              InkWell(
                child: const Icon(
                  Iconsax.copy_copy,
                  color: kColorGrey,
                  size: kTextSizeMd,
                ),
                onTap: () {},
              ),
              const Spacer(),
              Text(
                DateFormat('HH:mm dd/MM').format(order.orderTime!),
                style: AppTextStyle.medium(kTextSizeMd, kColorGrey),
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
            children: [
              Expanded(
                child: _CustomerInfo(order: order),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
                    decoration: BoxDecoration(
                      color: order.status == 'Đang xử lý'
                          ? Colors.orange.withOpacity(0.1)
                          : order.status == 'Hoàn tất'
                              ? Colors.green.withOpacity(0.1)
                              : order.status == 'Hủy'
                                  ? Colors.red.withOpacity(0.1)
                                  : Colors.transparent,
                      borderRadius: BorderRadius.circular(kBorderRadiusMd),
                    ),
                    child: Text(
                      order.status!,
                      style: AppTextStyle.medium(
                        kTextSizeMd,
                        order.status == 'Đang xử lý'
                            ? Colors.orange
                            : order.status == 'Hoàn tất'
                                ? Colors.green
                                : order.status == 'Hủy'
                                    ? Colors.red
                                    : kColorGrey,
                      ),
                    ),
                  ),
                  const SizedBox(height: kMarginMd),
                  Text(
                    'Tạo bởi ${order.executor!}',
                    style: AppTextStyle.medium(kTextSizeMd, kColorGrey),
                  ),
                ],
              )
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FormatText.formatCurrency(order.totalPrice!),
                    style: AppTextStyle.semibold(kTextSizeLg),
                  ),
                  const SizedBox(height: kMarginSm),
                  Text(
                    '${order.paymentStatus}',
                    style: AppTextStyle.medium(
                      kTextSizeMd,
                      order.paymentStatus == 'Đã thanh toán'
                          ? Colors.green
                          : order.paymentStatus == 'Thanh toán một phần'
                              ? Colors.orange
                              : Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: CustomButton(
                  textStyle: AppTextStyle.medium(kTextSizeSm, kColorWhite),
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
