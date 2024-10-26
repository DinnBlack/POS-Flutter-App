import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import '../../models/product_model.dart';
import '../../screens/services/product/product_create/product_create_screen.dart';
import '../../screens/services/product/sale_product/sale_product_dialog_screen.dart';

class CustomListProductsItem extends StatefulWidget {
  const CustomListProductsItem({
    super.key,
    required this.product,
    this.isOrderPage = true,
  });

  final ProductModel product;
  final bool isOrderPage;

  @override
  State<CustomListProductsItem> createState() => _CustomListProductsItemState();
}

class _CustomListProductsItemState extends State<CustomListProductsItem> {
  int quantity = 0;

  void showProductDetailsDialog() {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showProductDetailsDialog,
      child: Container(
        color: WHITE_COLOR,
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: SMALL_PADDING, vertical: DEFAULT_PADDING),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.product.title,
                        style: AppTextStyle.medium(
                            MEDIUM_TEXT_SIZE, BLACK_TEXT_COLOR)),
                    const Spacer(),
                    Text(widget.product.unit!,
                        style: AppTextStyle.light(
                            SMALL_TEXT_SIZE, LIGHT_BLACK_TEXT_COLOR)),
                    const Spacer(),
                    Text('${widget.product.price.toStringAsFixed(3)}đ',
                        style:
                        AppTextStyle.medium(MEDIUM_TEXT_SIZE, GREEN_COLOR)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
