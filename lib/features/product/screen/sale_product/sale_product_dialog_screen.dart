import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/features/order/bloc/order_bloc.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';

import '../../../../core/utils/format_text.dart';
import '../../model/product_model.dart';

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
        color: kColorWhite,
        borderRadius: BorderRadius.circular(kBorderRadiusMd),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 40,
            decoration: const BoxDecoration(
              color: kColorWhite,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(kBorderRadiusMd)),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'Thêm vào giỏ',
                    style: AppTextStyle.semibold(
                      kTextSizeMd
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
            color: kColorLightGrey,
          ),
          const SizedBox(
            height: kMarginMd,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kPaddingMd),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(kBorderRadiusMd),
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
                      width: kMarginMd,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title,
                          style: AppTextStyle.medium(kTextSizeMd),
                        ),
                        const SizedBox(height: kMarginMd),
                        widget.product.description != null &&
                                widget.product.description!.isNotEmpty
                            ? Column(
                                children: [
                                  Text(widget.product.description!),
                                  const SizedBox(height: kMarginMd),
                                ],
                              )
                            : const SizedBox.shrink(),
                        Text(
                          FormatText.formatCurrency(widget.product.price),
                          style:
                              AppTextStyle.medium(kTextSizeMd, kColorGreen),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kMarginMd),
              Container(
                height: 4,
                width: double.infinity,
                color: kColorLightGrey,
              ),
              const SizedBox(height: kMarginMd),
            ],
          ),

          const Spacer(),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: kColorWhite,
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(kBorderRadiusMd)),
              boxShadow: [
                BoxShadow(
                  color: kColorLightGrey,
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
                    padding: const EdgeInsets.all(kPaddingMd),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kColorLightGrey,
                        borderRadius:
                            BorderRadius.circular(kBorderRadiusMd),
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
                                kTextSizeMd),
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
                        backgroundColor: kColorPrimary,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'Cập nhật giỏ',
                        style:
                            AppTextStyle.semibold(kTextSizeMd, kColorWhite),
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
