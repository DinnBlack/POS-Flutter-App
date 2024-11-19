import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';
import '../model/category_model.dart';

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
                ? kColorPrimary.withOpacity(0.2)
                : (isHovered ? Colors.blue.shade50 : kColorWhite),
            border: Border.all(
              color: widget.isSelected ? kColorPrimary : kColorLightGrey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(kBorderRadiusMd),
          ),
          padding: const EdgeInsets.all(kPaddingMd),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.category.title,
                style: AppTextStyle.medium(
                  kTextSizeMd,
                  widget.isSelected ? kColorPrimary : kColorGrey,
                ),
              ),
              if (widget.isSelected)
                Row(
                  children: [
                    const SizedBox(width: kMarginSm,),
                    InkWell(
                      onTap: widget.onTap,
                      child: const Icon(Icons.close, color: Colors.red, size: kTextSizeMd,),
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
