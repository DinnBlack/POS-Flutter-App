import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import '../../../core/utils/app_text_style.dart';
import '../../../core/utils/format_text.dart';
import '../../../core/widgets/common_widgets/custom_button.dart';
import '../../../core/widgets/common_widgets/dashed_line_painter.dart';
import '../../../features/order/bloc/order_bloc.dart';
import '../../../features/product/model/product_model.dart';

class CustomListOrderProductItem extends StatefulWidget {
  final ProductModel product;

  const CustomListOrderProductItem({super.key, required this.product});

  @override
  _CustomListOrderProductItemState createState() =>
      _CustomListOrderProductItemState();
}

class _CustomListOrderProductItemState extends State<CustomListOrderProductItem>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  List<bool> _isSelectedToggle = [true, false];

  late TextEditingController _priceController;
  late TextEditingController _discountController;
  late TextEditingController _noteController;

  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(
        text: FormatText.formatCurrency((widget.product.promotionCost != null &&
                    widget.product.promotionCost! > 0
                ? widget.product.promotionCost!
                : widget.product.price) -
            widget.product.discount!));
    _priceController.addListener(_formatPriceInput);

    _discountController =
        TextEditingController(text: FormatText.formatPercentage(0));
    _discountController.addListener(_formatPriceInput);
    _noteController = TextEditingController(text: "Thêm ghi chú...");

    _isSelectedToggle = [false, true];

    _formatPriceInput();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _onTogglePressed(int index) {
    setState(() {
      _isSelectedToggle = _isSelectedToggle.asMap().entries.map((entry) {
        return entry.key == index;
      }).toList();

      if (_isSelectedToggle[0]) {
        _discountController.text = FormatText.formatCurrency(0);
      } else {
        _discountController.text = '0%';
      }

      _formatPriceInput();
    });
  }

  void _formatPriceInput() {
    if (_focusNodes[0].hasFocus) {
      String text = _priceController.text;
      String numericText = text.replaceAll(RegExp(r'[^\d]'), '');

      if (numericText.isNotEmpty) {
        int parsedAmount = int.tryParse(numericText) ?? 0;
        String formatted = FormatText.formatCurrency(parsedAmount);

        _priceController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length - 1),
        );
      } else {
        _priceController.value = const TextEditingValue(
          text: '0đ',
          selection: TextSelection.collapsed(offset: 0),
        );
      }
    }

    if (_focusNodes[1].hasFocus) {
      String text = _discountController.text;
      String numericText = text.replaceAll(RegExp(r'[^\d]'), '');

      if (numericText.isNotEmpty) {
        int parsedAmount = int.tryParse(numericText) ?? 0;

        if (_isSelectedToggle[1]) {
          parsedAmount = parsedAmount.clamp(0, 100);
          String formatted = "$parsedAmount%";
          _discountController.value = TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(offset: formatted.length - 1),
          );
        } else {
          // Apply currency format for discount
          String formatted = FormatText.formatCurrency(parsedAmount);
          _discountController.value = TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(offset: formatted.length - 1),
          );
        }
      } else {
        _discountController.value = const TextEditingValue(
          text: '0%',
          selection: TextSelection.collapsed(offset: 0),
        );
      }
    }
  }

  void _updateProductDetails() {
    try {
      int updatedPrice = FormatText.parseCurrency(_priceController.text);
      String discountText = _discountController.text;
      int updatedDiscount;

      if (_isSelectedToggle[1]) {
        int discountPercentage = int.parse(discountText.replaceAll('%', ''));
        updatedDiscount = (updatedPrice * discountPercentage) ~/ 100;
      } else {
        updatedDiscount = FormatText.parseCurrency(discountText).toInt();
      }

      print(updatedDiscount);

      String note = _noteController.text.trim();

      BlocProvider.of<OrderBloc>(context).add(UpdateProductDetailsStarted(
        product: widget.product.copyWith(
          price: updatedPrice,
          discount: updatedDiscount,
          note: note.isEmpty ? "No notes" : note,
        ),
        newPrice: updatedPrice,
        newDiscount: updatedDiscount,
        newNote: note.isEmpty ? "No notes" : note,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update product details: $e')),
      );
    }
  }

  @override
  void dispose() {
    _priceController.removeListener(_formatPriceInput);
    _priceController.dispose();
    _discountController.removeListener(_formatPriceInput);
    _discountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void addProductToOrderList() {
    setState(() {
      BlocProvider.of<OrderBloc>(context)
          .add(AddProductToOrderListStarted(widget.product));
    });
  }

  void removeProductFromOrderList() {
    setState(() {
      BlocProvider.of<OrderBloc>(context)
          .add(RemoveProductFromOrderListStarted(widget.product));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleExpand,
          child: Container(
            color: kColorWhite,
            padding: const EdgeInsets.symmetric(vertical: kPaddingMd),
            child: Row(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(kPaddingSm),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(kBorderRadiusMd),
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: (widget.product.image != null &&
                                  widget.product.image!.isNotEmpty)
                              ? Image.network(
                                  widget.product.image!.first,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/default_image.png',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/images/default_image.png',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<OrderBloc>(context).add(
                              RemoveProductFromOrderListStarted(widget.product,
                                  isRemoved: true));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(kPaddingSm),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: kMarginSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: kTextSizeMd,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FormatText.formatCurrency(
                                (widget.product.promotionCost != null &&
                                            widget.product.promotionCost! > 0
                                        ? widget.product.promotionCost! *
                                            widget.product.quantityOrder!
                                        : widget.product.price *
                                            widget.product.quantityOrder!) -
                                    widget.product.discount!),
                            style: AppTextStyle.medium(
                                kTextSizeMd, kColorPrimary),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 100,
                            padding: const EdgeInsets.symmetric(
                                vertical: kPaddingSm,
                                horizontal: kPaddingSm),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: kColorLightGrey),
                              borderRadius:
                                  BorderRadius.circular(kBorderRadiusMd),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    removeProductFromOrderList();
                                  },
                                  child: const Icon(
                                    Icons.remove_rounded,
                                  ),
                                ),
                                Text(
                                  '${widget.product.quantityOrder}',
                                  style: AppTextStyle.medium(kTextSizeMd),
                                ),
                                InkWell(
                                  onTap: () {
                                    addProductToOrderList();
                                  },
                                  child: const Icon(
                                    Icons.add_rounded,
                                    color: kColorPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _isExpanded
              ? Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: kPaddingSm),
                      child: CustomPaint(
                        size: const Size(double.infinity, 1),
                        painter: DashedLinePainter(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: kPaddingSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildEditableRow(
                              "Giá bán",
                              FormatText.formatCurrency(
                                  (widget.product.promotionCost! > 0
                                          ? widget.product.promotionCost!
                                          : widget.product.price) -
                                      widget.product.discount!),
                              index: 0),
                          _buildEditableRow(
                              "Giảm giá", FormatText.formatPercentage(0),
                              hasToggle: true, index: 1),
                          _buildEditableRow("Ghi chú", "Thêm ghi chú...",
                              index: 2),
                          SizedBox(
                            height: 40,
                            child: CustomButton(
                              text: "Cập nhật",
                              onPressed: _updateProductDetails,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildEditableRow(String label, String value,
      {bool hasToggle = false, int? index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                label,
                style: AppTextStyle.medium(kTextSizeMd, kColorGrey),
              ),
              const SizedBox(width: kMarginSm),
              if (hasToggle)
                ToggleButtons(
                  borderRadius: BorderRadius.circular(kBorderRadiusMd),
                  constraints: const BoxConstraints(minHeight: 30),
                  isSelected: _isSelectedToggle,
                  onPressed: _onTogglePressed,
                  children: const [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kPaddingMd),
                      child: Text('VND'),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kPaddingMd),
                      child: Text('%'),
                    ),
                  ],
                ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: index == 0
                        ? _priceController
                        : index == 1
                            ? _discountController
                            : _noteController,
                    keyboardType: (label == "Giá bán" || label == "Giảm giá")
                        ? TextInputType.number
                        : TextInputType.text,
                    inputFormatters: (label == "Giá bán" || label == "Giảm giá")
                        ? [FilteringTextInputFormatter.digitsOnly]
                        : [],
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: kPaddingSm),
                    ),
                    style:
                        AppTextStyle.semibold(kTextSizeMd, kColorPrimary),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    focusNode: index != null ? _focusNodes[index] : null,
                    onTap: () {
                      if (index == 2) {
                        if (_noteController.text == "Thêm ghi chú...") {
                          _noteController.clear();
                        }
                        _noteController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _noteController.text.length),
                        );
                      }
                    },
                    onChanged: (text) {
                      if (text.isEmpty) {
                        _noteController.text = "Thêm ghi chú...";
                        _noteController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _noteController.text.length - 1),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: kMarginSm),
                InkWell(
                  child: const Icon(
                    Icons.edit_note_outlined,
                    size: 16,
                    color: kColorPrimary,
                  ),
                  onTap: () {
                    if (index != null) {
                      FocusScope.of(context).requestFocus(_focusNodes[index]);
                      TextEditingController controller = index == 0
                          ? _priceController
                          : index == 1
                              ? _discountController
                              : _noteController;

                      controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller.text.length),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
