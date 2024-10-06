import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/models/order_model.dart';
import 'package:pos_flutter_app/screens/services/orders/order_details/order_details_dialog/order_details_dialog_screen.dart';
import 'package:pos_flutter_app/utils/ui_util/app_colors.dart';

class CustomListTrackOrdersItem extends StatefulWidget {
  final OrderModel order;

  const CustomListTrackOrdersItem({
    super.key,
    required this.order,
  });

  @override
  _CustomListTrackOrdersItemState createState() =>
      _CustomListTrackOrdersItemState();
}

class _CustomListTrackOrdersItemState extends State<CustomListTrackOrdersItem> {
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;

    switch (widget.order.status) {
      case 'Pending':
        statusColor = Colors.orange;
        statusIcon = Iconsax.clock;
        break;
      case 'Completed':
        statusColor = Colors.green;
        statusIcon = Iconsax.check;
        break;
      case 'Cancelled':
        statusColor = Colors.red;
        statusIcon = Iconsax.close_circle;
        break;
      default:
        statusColor = AppColors.primary;
        statusIcon = Iconsax.info_circle;
        break;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showOrderDetailsDialog(context),
        child: Container(
          height: 220,
          constraints: const BoxConstraints(maxWidth: 180),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(width: 1, color: AppColors.grey.withOpacity(0.2)),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Iconsax.shopping_bag_copy,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text('#${widget.order.orderId}'),
                  const Spacer(),
                  Text('${widget.order.products.length} items'),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _buildProductList(),
              ),
              const SizedBox(height: 10),
              Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.order.status,
                      style: const TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                    Icon(statusIcon, color: AppColors.white),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductList() {
    int itemsToShow = _showMore
        ? widget.order.products.length
        : (widget.order.products.length < 3 ? widget.order.products.length : 3);

    bool showMoreButton = widget.order.products.length > 3;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: itemsToShow + (showMoreButton ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < itemsToShow) {
                final product = widget.order.products[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    '1x ${product.title}',
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              } else if (showMoreButton) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _showMore = !_showMore;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      _showMore ? 'See less' : 'See more',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  void _showOrderDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OrderDetailsDialogScreen(order: widget.order);
      },
    );
  }
}
