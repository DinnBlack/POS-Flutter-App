import 'package:flutter/material.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/utils/app_text_style.dart';
import '../model/category_model.dart';

class CustomListCategoriesItem extends StatefulWidget {
  const CustomListCategoriesItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    this.isVertical = false,
    this.isOrderPage = false,
  });

  final CategoryModel category;
  final bool isSelected;
  final bool isVertical;
  final VoidCallback onTap;
  final bool? isOrderPage;

  @override
  _CustomListCategoriesItemState createState() =>
      _CustomListCategoriesItemState();
}

class _CustomListCategoriesItemState extends State<CustomListCategoriesItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return widget.isVertical ? _buildVerticalItem() : _buildHorizontalItem();
  }

  Widget _buildVerticalItem() {
    if (widget.isOrderPage == true) {
      return GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(kPaddingMd),
          width: double.infinity,
          color: widget.isSelected ? kColorWhite : kColorLightGrey,
          child: Text(
            widget.category.title,
            style: AppTextStyle.medium(
              kTextSizeMd,
              widget.isSelected ? kColorPrimary : kColorGrey,
            ),
          ),
        ),
      );
    }


    // Otherwise, return the normal vertical item
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
          height: 80,
          decoration: BoxDecoration(
            color: kColorWhite,
            borderRadius: BorderRadius.circular(kBorderRadiusMd),
          ),
          padding: const EdgeInsets.all(kPaddingMd),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: kPaddingMd),
                child: Icon(
                  Icons.drag_indicator,
                  color: kColorGrey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.category.title,
                    style: AppTextStyle.medium(kTextSizeSm),
                  ),
                  Text(
                    '${widget.category.count} items',
                    style: AppTextStyle.medium(
                      kTextSizeSm,
                      kColorGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalItem() {
    if (widget.isOrderPage == true) {
      return GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
          child: Text(
            widget.category.title,
            style: AppTextStyle.medium(kTextSizeSm),
          ),
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        isHovered = false;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 40,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: kColorWhite,
              border: Border.all(
                color: widget.isSelected ? kColorPrimary : kColorLightGrey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(kBorderRadiusMd),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: kPaddingMd,
              horizontal: kPaddingMd,
            ),
            child: Text(
              widget.category.title,
              style: AppTextStyle.medium(
                kTextSizeSm,
                widget.isSelected ? kColorPrimary : kColorGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
