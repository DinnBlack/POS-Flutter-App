import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/features/order/bloc/order_bloc.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

import '../../../../models/product_model.dart';
import '../../../../utils/ui_util/format_text.dart';

class SaleProductDialogScreen extends StatefulWidget {
  const SaleProductDialogScreen({
    super.key,
    required this.product,
    required this.onQuantityChanged,
  });

  final ProductModel product;
  final ValueChanged<int> onQuantityChanged;

  @override
  State<SaleProductDialogScreen> createState() =>
      _SaleProductDialogScreenState();
}

class _SaleProductDialogScreenState extends State<SaleProductDialogScreen> {
  int quantity = 1;

  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 40,
            decoration: const BoxDecoration(
              color: WHITE_COLOR,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(DEFAULT_BORDER_RADIUS)),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'Thêm vào giỏ',
                    style: AppTextStyle.semibold(
                      MEDIUM_TEXT_SIZE,
                      BLACK_TEXT_COLOR,
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close_rounded,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: GREY_LIGHT_COLOR,
          ),
          const SizedBox(
            height: DEFAULT_MARGIN,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(DEFAULT_BORDER_RADIUS),
                      child: widget.product.image != null &&
                              widget.product.image!.isNotEmpty
                          ? Image.network(
                              widget.product.image!.first,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/default_image.png',
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(
                      width: DEFAULT_MARGIN,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title,
                          style: AppTextStyle.medium(LARGE_TEXT_SIZE),
                        ),
                        const SizedBox(height: SMALL_MARGIN),
                        widget.product.description != null &&
                                widget.product.description!.isNotEmpty
                            ? Column(
                                children: [
                                  Text(widget.product.description!),
                                  const SizedBox(height: SMALL_MARGIN),
                                ],
                              )
                            : const SizedBox.shrink(),
                        Text(
                          FormatText.formatCurrency(widget.product.price),
                          style:
                              AppTextStyle.medium(LARGE_TEXT_SIZE, GREEN_COLOR),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DEFAULT_MARGIN),
              Container(
                height: 4,
                width: double.infinity,
                color: GREY_LIGHT_COLOR,
              ),
              const SizedBox(height: DEFAULT_MARGIN),
            ],
          ),

          const Spacer(),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: WHITE_COLOR,
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(DEFAULT_BORDER_RADIUS)),
              boxShadow: [
                BoxShadow(
                  color: GREY_LIGHT_COLOR,
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(DEFAULT_PADDING),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: GREY_LIGHT_COLOR,
                        borderRadius:
                            BorderRadius.circular(MEDIUM_BORDER_RADIUS),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Iconsax.minus_cirlce),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                  widget.onQuantityChanged(quantity);
                                }
                              });
                            },
                          ),
                          Text(
                            '$quantity',
                            style: AppTextStyle.semibold(
                                LARGE_TEXT_SIZE, BLACK_TEXT_COLOR),
                          ),
                          IconButton(
                            icon: const Icon(Iconsax.add_circle),
                            onPressed: () {
                              setState(() {
                                quantity++;
                                widget.onQuantityChanged(quantity);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final updatedProduct =
                            widget.product.copyWith(quantityOrder: quantity);

                        context
                            .read<OrderBloc>()
                            .add(AddProductToOrderListStarted(updatedProduct));
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'Cập nhật giỏ',
                        style:
                            AppTextStyle.semibold(LARGE_TEXT_SIZE, WHITE_COLOR),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
