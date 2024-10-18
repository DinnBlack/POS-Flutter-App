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
  });

  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  _CustomListCategoriesItemState createState() =>
      _CustomListCategoriesItemState();
}

class _CustomListCategoriesItemState extends State<CustomListCategoriesItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
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
                ? PRIMARY_COLOR
                : (isHovered ? Colors.blue.shade100 : Colors.white),
            border: Border.all(
              color: widget.isSelected ? PRIMARY_COLOR : GREY_LIGHT_COLOR,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
          ),
          padding: const EdgeInsets.all(DEFAULT_PADDING),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.category.title,
                  style: AppTextStyle.semibold(
                    MEDIUM_TEXT_SIZE,
                    widget.isSelected ? WHITE_COLOR : BLACK_TEXT_COLOR,
                  ),
                ),
                Text(
                  '${widget.category.count} items',
                  style: AppTextStyle.medium(
                    SMALL_TEXT_SIZE,
                    widget.isSelected ? WHITE_COLOR : GREY_COLOR,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
