import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import 'package:pos_flutter_app/utils/ui_util/format_text.dart';
import '../../models/product_model.dart';
import '../../screens/services/product/sale_product/sale_product_dialog_screen.dart';

class CustomGridProductsItem extends StatefulWidget {
  const CustomGridProductsItem({super.key, required this.product});

  final ProductModel product;

  @override
  State<CustomGridProductsItem> createState() => _CustomGridProductsItemState();
}

class _CustomGridProductsItemState extends State<CustomGridProductsItem> {
  int quantity = 0;

  void showProductDetailsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SaleProductDialogScreen(
          product: widget.product,
          onQuantityChanged: (newQuantity) {
            setState(() {
              quantity = newQuantity;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showProductDetailsDialog,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
          color: WHITE_COLOR,
          border: Border.all(
            color: quantity > 0 ? PRIMARY_COLOR : TRANSPATENT_COLOR,
            width: quantity > 0 ? 1 : 0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(SMALL_PADDING),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
                child: widget.product.image != null &&
                    widget.product.image!.isNotEmpty
                    ? Image.network(
                  widget.product.image!.first,
                  height: 80,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  'assets/images/default_image.png',
                  height: 80,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.title,
                      style: AppTextStyle.medium(
                          MEDIUM_TEXT_SIZE, BLACK_TEXT_COLOR),maxLines: 1, overflow: TextOverflow.ellipsis,),
                  Text(widget.product.unit!,
                      style: AppTextStyle.light(
                          SMALL_TEXT_SIZE, LIGHT_BLACK_TEXT_COLOR)),
                  Text(FormatText.formatCurrency(widget.product.price),
                      style:
                          AppTextStyle.medium(MEDIUM_TEXT_SIZE, GREEN_COLOR)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
