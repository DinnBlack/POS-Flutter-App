import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';

import '../../../../models/product_model.dart';
import '../../../../widgets/common_widgets/custom_text_field.dart';

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
    return Dialog(
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          color: WHITE_COLOR,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: WHITE_COLOR,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
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
                      'Details Menu',
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
                        Iconsax.close_square,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: widget.product.image != null &&
                              widget.product.image!.isNotEmpty
                          ? Image.network(
                              widget.product.image!.first,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/default_image.png',
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(height: DEFAULT_MARGIN),
                    Text(
                      widget.product.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
                      '\$${widget.product.price}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: DEFAULT_MARGIN),
                    CustomTextField(
                      hintText: 'Add note to your order...',
                      maxLines: 5,
                      minLines: 1,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: DEFAULT_MARGIN),
                  ],
                ),
              ),
            ),
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(DEFAULT_PADDING),
                    child: Container(
                      width: double.infinity,
                      height: 40,
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
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(DEFAULT_BORDER_RADIUS)),
                        ),
                      ),
                      child: Text(
                        'Add to Cart (\$${(widget.product.price * quantity).toStringAsFixed(2)})',
                        style:
                            AppTextStyle.semibold(LARGE_TEXT_SIZE, WHITE_COLOR),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
