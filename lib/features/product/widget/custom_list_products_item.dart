import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';
import '../model/product_model.dart';
import '../screen/product_create/product_create_screen.dart';
import '../screen/sale_product/sale_product_dialog_screen.dart';
import '../../../core/utils/format_text.dart';

class CustomListProductsItem extends StatefulWidget {
  const CustomListProductsItem({
    super.key,
    required this.product,
    this.isOrderPage = true,
    this.shouldShowDialog = true,
    this.showQuantityCount = true,
  });

  final ProductModel product;
  final bool isOrderPage;
  final bool shouldShowDialog;
  final bool showQuantityCount;

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
        color: kColorWhite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(kBorderRadiusMd),
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
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: kColorPrimary,
                        // Background color
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.product.quantityOrder.toString(),
                        style: AppTextStyle.bold(
                            kTextSizeSm, Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(kPaddingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.product.title,
                    style: AppTextStyle.medium(kTextSizeMd),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'size L, không đường, đá vừa, ngọt nhiều',
                    style: AppTextStyle.medium(kTextSizeSm, kColorGrey, true),
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
                    style: AppTextStyle.semibold(kTextSizeMd),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Conditionally show the quantity controls
            if (widget.showQuantityCount)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (quantity > 0) quantity--;
                      });
                      // removeProductFromOrderList();
                    },
                    child: const Icon(Icons.remove_circle_rounded,
                        color: kColorPrimary),
                  ),
                  SizedBox(
                    width: 20,
                    child: Text(
                      quantity.toString(),
                      style: AppTextStyle.medium(kTextSizeMd),
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
                        color: kColorPrimary),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
