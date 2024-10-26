import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import '../../../models/category_model.dart';
import '../../utils/constants/constants.dart';

class CustomListCategoriesAddProductItem extends StatefulWidget {
  const CustomListCategoriesAddProductItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    this.isVertical = false,
  });

  final CategoryModel category;
  final bool isSelected;
  final bool isVertical;
  final VoidCallback onTap;

  @override
  _CustomListCategoriesAddProductItemState createState() =>
      _CustomListCategoriesAddProductItemState();
}

class _CustomListCategoriesAddProductItemState extends State<CustomListCategoriesAddProductItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return _buildHorizontalItem();
  }

  Widget _buildHorizontalItem() {
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        isHovered = false;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? PRIMARY_COLOR.withOpacity(0.2)
                : (isHovered ? Colors.blue.shade50 : WHITE_COLOR),
            border: Border.all(
              color: widget.isSelected ? PRIMARY_COLOR : GREY_LIGHT_COLOR,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
          ),
          padding: const EdgeInsets.all(DEFAULT_PADDING),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.category.title,
                style: AppTextStyle.medium(
                  MEDIUM_TEXT_SIZE,
                  widget.isSelected ? PRIMARY_COLOR : GREY_COLOR,
                ),
              ),
              if (widget.isSelected)
                Row(
                  children: [
                    const SizedBox(width: SMALL_MARGIN,),
                    InkWell(
                      onTap: widget.onTap,
                      child: const Icon(Icons.close, color: Colors.red, size: MEDIUM_TEXT_SIZE,),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
