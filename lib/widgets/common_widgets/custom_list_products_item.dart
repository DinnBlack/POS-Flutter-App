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
    this.shouldShowDialog = true,
  });

  final ProductModel product;
  final bool isOrderPage;
  final bool shouldShowDialog;

  @override
  State<CustomListProductsItem> createState() => _CustomListProductsItemState();
}

class _CustomListProductsItemState extends State<CustomListProductsItem> {
  int quantity = 0;

  void showProductDetailsDialog() {
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
        padding: const EdgeInsets.all(DEFAULT_PADDING),
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
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
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: SMALL_PADDING, vertical: DEFAULT_PADDING),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.product.title,
                    style:
                        AppTextStyle.medium(SMALL_TEXT_SIZE, BLACK_TEXT_COLOR),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    FormatText.formatCurrency(
                        (widget.product.promotionCost != null &&
                                    widget.product.promotionCost! > 0
                                ? widget.product.promotionCost!
                                : widget.product.price) -
                            widget.product.discount!),
                    style: AppTextStyle.semibold(MEDIUM_TEXT_SIZE),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      quantity--;
                    });
                    // removeProductFromOrderList();
                  },
                  child: const Icon(Icons.remove_circle_rounded,
                      color: PRIMARY_COLOR),
                ),
                SizedBox(
                  width: 20,
                  child: Text(
                    quantity.toString(),
                    style: AppTextStyle.medium(MEDIUM_TEXT_SIZE),
                    textAlign: TextAlign.center,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      quantity++;
                    });
                    // addProductToOrderList();
                  },
                  child: const Icon(Icons.add_circle_rounded,
                      color: PRIMARY_COLOR),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
