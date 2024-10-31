import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:pos_flutter_app/utils/ui_util/format_text.dart';

import '../../models/product_model.dart';
import '../../utils/constants/constants.dart';
import '../../utils/ui_util/app_text_style.dart';
import '../common_widgets/dashed_line_painter.dart';

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

  // Tạo một danh sách FocusNode để quản lý tiêu điểm cho các trường văn bản
  final List<FocusNode> _focusNodes = [
    FocusNode(), // FocusNode cho "Giá bán"
    FocusNode(), // FocusNode cho "Giảm giá"
    FocusNode(), // FocusNode cho "Ghi chú"
  ];

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
    });
  }

  @override
  void initState() {
    super.initState();
    // Khởi tạo các TextEditingController với giá trị ban đầu
    _priceController = TextEditingController(text: FormatText.formatCurrency(widget.product.price));
    _discountController = TextEditingController(text: "0"); // hoặc giá trị mặc định khác
    _noteController = TextEditingController(text: "Thêm ghi chú...");
  }

  @override
  void dispose() {
    // Giải phóng các TextEditingController khi không còn sử dụng
    _priceController.dispose();
    _discountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleExpand,
          child: Container(
            color: WHITE_COLOR,
            padding: const EdgeInsets.symmetric(vertical: DEFAULT_PADDING),
            child: Row(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(SMALL_PADDING),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(SMALL_BORDER_RADIUS),
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
                          // Handle delete action here
                        },
                        child: Container(
                          padding: const EdgeInsets.all(SMALL_PADDING),
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
                const SizedBox(width: SMALL_MARGIN),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: MEDIUM_TEXT_SIZE,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FormatText.formatCurrency(widget.product.price),
                            style: AppTextStyle.medium(
                                MEDIUM_TEXT_SIZE, PRIMARY_COLOR),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 100,
                            padding: const EdgeInsets.symmetric(
                                vertical: SMALL_PADDING,
                                horizontal: SMALL_PADDING),
                            decoration: BoxDecoration(
                              border:
                              Border.all(width: 1, color: GREY_LIGHT_COLOR),
                              borderRadius:
                              BorderRadius.circular(SMALL_BORDER_RADIUS),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.remove_rounded,
                                  ),
                                ),
                                Text(
                                  '${widget.product.quantityOrder}',
                                  style: AppTextStyle.medium(MEDIUM_TEXT_SIZE),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.add_rounded,
                                    color: PRIMARY_COLOR,
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
                const EdgeInsets.symmetric(vertical: SMALL_PADDING),
                child: CustomPaint(
                  size: const Size(double.infinity, 1),
                  painter: DashedLinePainter(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: SMALL_PADDING),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEditableRow("Giá bán",
                        FormatText.formatCurrency(widget.product.price), index: 0),
                    _buildEditableRow("Giảm giá", "0", hasToggle: true, index: 1),
                    _buildEditableRow("Ghi chú", "Thêm ghi chú...", index: 2),
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
                style: AppTextStyle.medium(MEDIUM_TEXT_SIZE, GREY_COLOR),
              ),
              const SizedBox(width: SMALL_MARGIN),
              if (hasToggle)
                ToggleButtons(
                  borderRadius: BorderRadius.circular(SMALL_BORDER_RADIUS),
                  constraints: const BoxConstraints(minHeight: 30),
                  isSelected: _isSelectedToggle,
                  onPressed: _onTogglePressed,
                  children: const [
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
                      child: Text('VND'),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
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
                    controller: index == 0 ? _priceController :
                    index == 1 ? _discountController :
                    _noteController,
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
                      EdgeInsets.symmetric(vertical: SMALL_PADDING),
                    ),
                    style:
                    AppTextStyle.semibold(MEDIUM_TEXT_SIZE, PRIMARY_COLOR),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    focusNode: index != null ? _focusNodes[index] : null,
                  ),
                ),
                const SizedBox(width: SMALL_MARGIN,),
                InkWell(
                  child: const Icon(Icons.edit_note_outlined, size: 16, color: PRIMARY_COLOR),
                  onTap: () {
                    // Yêu cầu tiêu điểm vào trường văn bản tương ứng
                    if (index != null) {
                      FocusScope.of(context).requestFocus(_focusNodes[index]);
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
