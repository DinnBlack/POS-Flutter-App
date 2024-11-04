import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import '../../models/product_model.dart';
import '../../screens/services/product/product_create/product_create_screen.dart';
import '../../screens/services/product/sale_product/sale_product_dialog_screen.dart';
import '../../utils/ui_util/format_text.dart';

class CustomListProductsItem extends StatefulWidget {
  const CustomListProductsItem({
    super.key,
    required this.product,
    this.isOrderPage = true,
    this.shouldShowDialog = true, // New parameter with default value
  });

  final ProductModel product;
  final bool isOrderPage;
  final bool shouldShowDialog; // New parameter to control dialog display

  @override
  State<CustomListProductsItem> createState() => _CustomListProductsItemState();
}

class _CustomListProductsItemState extends State<CustomListProductsItem> {
  int quantity = 0;

  void showProductDetailsDialog() {
    // Check if dialog should be shown based on shouldShowDialog parameter
    if (widget.shouldShowDialog) {
      if (widget.isOrderPage) {
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
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductCreateScreen(
              isEditing: true,
              existingProduct: widget.product,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showProductDetailsDialog,
      child: Container(
        color: WHITE_COLOR,
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(DEFAULT_PADDING),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
                child: widget.product.image != null &&
                    widget.product.image!.isNotEmpty
                    ? Image.network(
                  widget.product.image!.first,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  'assets/images/default_image.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SMALL_PADDING, vertical: DEFAULT_PADDING),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.product.title,
                      style: AppTextStyle.semibold(MEDIUM_TEXT_SIZE)),
                  Text('SL: ${widget.product.quantityOrder}',
                      style:
                      AppTextStyle.medium(MEDIUM_TEXT_SIZE, GREEN_COLOR)),
                ],
              ),
            ),
            const Spacer(),
            Text(
              FormatText.formatCurrency((widget.product.promotionCost! > 0
                  ? widget.product.promotionCost! *
                  (widget.product.quantityOrder ?? 0)
                  : widget.product.price *
                  (widget.product.quantityOrder ?? 0)) -
                  (widget.product.discount ?? 0)),
              style: AppTextStyle.semibold(LARGE_TEXT_SIZE),
            ),
          ],
        ),
      ),
    );
  }
}
