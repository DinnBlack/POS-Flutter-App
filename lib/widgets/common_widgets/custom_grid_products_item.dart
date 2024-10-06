import 'package:flutter/material.dart';
import 'package:pos_flutter_app/screens/services/products/sale_product/sale_product_dialog_screen.dart';
import 'package:pos_flutter_app/utils/ui_util/app_colors.dart';
import '../../models/product_model.dart';

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
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
          border: Border.all(
            color: quantity > 0 ? AppColors.primary : Colors.transparent,
            width: quantity > 0 ? 1 : 0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.product.image,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.product.unit,
                      style: const TextStyle(color: Colors.grey)),
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.green),
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
