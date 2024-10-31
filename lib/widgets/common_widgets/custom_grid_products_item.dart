import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/features/order/bloc/order_bloc.dart';

import '../../models/product_model.dart';
import '../../screens/services/product/sale_product/sale_product_dialog_screen.dart';
import '../../utils/constants/constants.dart';
import '../../utils/ui_util/app_text_style.dart';
import '../../utils/ui_util/format_text.dart';
import '../../features/product/bloc/product_bloc.dart';

class CustomGridProductsItem extends StatefulWidget {
  const CustomGridProductsItem({super.key, required this.product});

  final ProductModel product;

  @override
  State<CustomGridProductsItem> createState() => _CustomGridProductsItemState();
}

class _CustomGridProductsItemState extends State<CustomGridProductsItem> {
  int quantity = 0;

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
          },
        );
      },
    );
  }

  void addProductToOrderList() {
    BlocProvider.of<OrderBloc>(context).add(AddProductToOrderListStarted(widget.product));
  }

  void removeProductFromOrderList() {
    BlocProvider.of<OrderBloc>(context).add(RemoveProductFromOrderListStarted(widget.product));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.product.options!.isNotEmpty) {
          showProductDetailsDialog();
        } else {
          setState(() {
            quantity = quantity == 0 ? 1 : quantity + 1;
          });
          addProductToOrderList();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SMALL_BORDER_RADIUS),
          color: WHITE_COLOR,
          border: Border.all(
            color: quantity > 0 ? PRIMARY_COLOR : GREY_LIGHT_COLOR,
            width: quantity > 0 ? 1 : 0,
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
                          top: Radius.circular(SMALL_BORDER_RADIUS)),
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: DEFAULT_MARGIN, vertical: DEFAULT_MARGIN),
                        padding: const EdgeInsets.symmetric(vertical: SMALL_PADDING),
                        decoration: BoxDecoration(
                          color: WHITE_COLOR.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(SMALL_BORDER_RADIUS),
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
                              child: const Icon(Icons.remove_rounded, color: PRIMARY_COLOR),
                            ),
                            Text(
                              quantity.toString(),
                              style: AppTextStyle.medium(MEDIUM_TEXT_SIZE),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                                addProductToOrderList();
                              },
                              child: const Icon(Icons.add_rounded, color: PRIMARY_COLOR),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(
                      horizontal: DEFAULT_PADDING, vertical: SMALL_PADDING),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.product.title,
                            style: AppTextStyle.medium(
                                SMALL_TEXT_SIZE, BLACK_TEXT_COLOR),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          FormatText.formatCurrency(widget.product.price),
                          style: AppTextStyle.semibold(MEDIUM_TEXT_SIZE),
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
