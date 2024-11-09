import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

import '../../../../../models/order_model.dart';
import '../../../../../widgets/normal_widgets/custom_list_order_details_dialog_item.dart';

class OrderDetailsDialogScreen extends StatelessWidget {
  const OrderDetailsDialogScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          color: WHITE_COLOR,
          borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: WHITE_COLOR,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(DEFAULT_BORDER_RADIUS)),
                boxShadow: [
                  BoxShadow(
                    color: GREY_LIGHT_COLOR,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      'Order Details #${order.orderId}',
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Iconsax.close_square,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
                decoration: const BoxDecoration(
                  color: WHITE_COLOR,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(DEFAULT_BORDER_RADIUS),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Customer: ${order.customer?.name}'),
                    Text('Total Items: ${order.products?.length}'),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: order.products?.length,
                      itemBuilder: (context, index) {
                        final product = order.products?[index];
                        return CustomListOrderDetailsDialogItem(
                            product: product!);
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Total Price: \$${order.totalPrice}',
                      style: AppTextStyle.medium(MEDIUM_BORDER_RADIUS, BLACK_TEXT_COLOR)
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
