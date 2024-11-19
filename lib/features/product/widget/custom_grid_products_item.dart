import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';

import '../../order/bloc/order_bloc.dart';
import '../model/product_model.dart';
import '../screen/product_create/product_create_screen.dart';
import '../screen/sale_product/sale_product_dialog_screen.dart';
import '../../../core/utils/app_text_style.dart';
import '../../../core/utils/format_text.dart';

class CustomGridProductsItem extends StatefulWidget {
  const CustomGridProductsItem({
    super.key,
    required this.product,
    required this.isOrderPage,
  });

  final ProductModel product;
  final bool isOrderPage;

  @override
  State<CustomGridProductsItem> createState() => _CustomGridProductsItemState();
}

class _CustomGridProductsItemState extends State<CustomGridProductsItem> {
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    _updateQuantityFromOrderBloc();
  }

  void _updateQuantityFromOrderBloc() {
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    final selectedItem = orderBloc.orderProductList.firstWhere(
      (item) => item.title == widget.product.title,
      orElse: () => ProductModel(title: '', price: 0),
    );

    setState(() {
      if (!mounted) return;
      quantity = selectedItem?.quantityOrder ?? 0;
    });
  }

  void showProductDetailsDialog() {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SaleProductDialogScreen(
          product: widget.product,
          onQuantityChanged: (newQuantity) {
            setState(() {
              quantity = newQuantity;
            });
            if (newQuantity > 0) {
              addProductToOrderList();
            } else {
              removeProductFromOrderList();
            }
          },
        );
      },
    );
  }

  void addProductToOrderList() {
    BlocProvider.of<OrderBloc>(context)
        .add(AddProductToOrderListStarted(widget.product));
  }

  void removeProductFromOrderList() {
    BlocProvider.of<OrderBloc>(context)
        .add(RemoveProductFromOrderListStarted(widget.product));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isOrderPage) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductCreateScreen(
                existingProduct: widget.product,
                isEditing: true,
              ),
            ),
          );
        } else {
          if (widget.product.request != null &&
              widget.product.request!.isNotEmpty) {
            showProductDetailsDialog();
          } else {
            setState(() {
              quantity = quantity == 0 ? 1 : quantity + 1;
            });
            addProductToOrderList();
          }
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadiusMd),
          color: kColorWhite,
          border: Border.all(
            color: quantity > 0 ? kColorPrimary : kColorGrey.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(kBorderRadiusMd)),
                      child: widget.product.image != null &&
                              widget.product.image!.isNotEmpty
                          ? Image.network(
                              widget.product.image!.first,
                              height: 60,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/default_image.png',
                              height: 60,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                    if (quantity > 0)
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        margin: const EdgeInsets.all(kMarginMd),
                        padding:
                            const EdgeInsets.symmetric(vertical: kPaddingMd),
                        decoration: BoxDecoration(
                          color: kColorWhite.withOpacity(0.9),
                          borderRadius:
                              BorderRadius.circular(kBorderRadiusMd),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  quantity--;
                                });
                                removeProductFromOrderList();
                              },
                              child: const Icon(Icons.remove_rounded,
                                  color: kColorPrimary),
                            ),
                            Text(
                              quantity.toString(),
                              style: AppTextStyle.medium(kTextSizeMd),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                                addProductToOrderList();
                              },
                              child: const Icon(Icons.add_rounded,
                                  color: kColorPrimary),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPaddingMd, vertical: kPaddingSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.product.title,
                            style: AppTextStyle.medium(
                                kTextSizeSm),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          FormatText.formatCurrency(
                              (widget.product.promotionCost != null &&
                                          widget.product.promotionCost! > 0
                                      ? widget.product.promotionCost!
                                      : widget.product.price) -
                                  widget.product.discount!),
                          style: AppTextStyle.semibold(kTextSizeSm),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
