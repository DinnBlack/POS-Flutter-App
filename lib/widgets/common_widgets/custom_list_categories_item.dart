import 'package:flutter/material.dart';
import 'package:pos_flutter_app/utils/ui_util/app_text_style.dart';
import '../../../models/category_model.dart';
import '../../utils/constants/constants.dart';

class CustomListCategoriesItem extends StatefulWidget {
  const CustomListCategoriesItem({
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
            color: WHITE_COLOR,
            borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
          ),
          padding: const EdgeInsets.all(DEFAULT_PADDING),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: DEFAULT_PADDING),
                child: Icon(
                  Icons.drag_indicator,
                  color: GREY_COLOR,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.category.title,
                    style: AppTextStyle.medium(
                      MEDIUM_TEXT_SIZE,
                    ),
                  ),
                  Text(
                    '${widget.category.count} items',
                    style: AppTextStyle.medium(
                      SMALL_TEXT_SIZE,
                      GREY_COLOR,
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
              color: WHITE_COLOR,
              border: Border.all(
                color: widget.isSelected ? PRIMARY_COLOR : GREY_LIGHT_COLOR,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
            ),
            padding: const EdgeInsets.symmetric(vertical: DEFAULT_PADDING, horizontal: MEDIUM_PADDING),
            child: Text(
              widget.category.title,
              style: AppTextStyle.medium(
                MEDIUM_TEXT_SIZE,
                widget.isSelected ? PRIMARY_COLOR : GREY_COLOR,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
