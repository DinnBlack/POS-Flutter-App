import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../models/product_model.dart';
import '../../../../utils/ui_util/app_colors.dart';
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
  @override
  int quantity = 1;

  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey_02,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Text(
                      'Details Menu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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
                        color: AppColors.primary,
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
                      child: Image.asset(
                        widget.product.image,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.product.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Phở Bò không chỉ là món ăn còn là một trải nghiệm ẩm thực thú vị, khiến ai một lần thưởng thức đều nhớ mãi.',
                      style: TextStyle(),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$${widget.product.price}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Add note to your order...',
                      maxLines: 5,
                      minLines: 1,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey_02,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.grey_02,
                        borderRadius: BorderRadius.circular(20),
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
                            style: const TextStyle(fontSize: 20),
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
                        backgroundColor: AppColors.primary,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10)),
                        ),
                      ),
                      child: Text(
                        'Add to Cart (\$${(widget.product.price * quantity).toStringAsFixed(2)})',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
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
