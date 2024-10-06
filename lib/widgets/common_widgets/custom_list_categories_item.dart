import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/utils/ui_util/app_colors.dart';
import '../../../models/category_model.dart';

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

class _CustomListCategoriesItemState
    extends State<CustomListCategoriesItem> {
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
                ? AppColors.primary
                : (isHovered ? Colors.blue.shade100 : Colors.white),
            border: Border.all(
              color: widget.isSelected ? AppColors.primary : AppColors.grey_02,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  widget.category.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: widget.isSelected ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  '${widget.category.count} items',
                  style: TextStyle(
                    color: widget.isSelected ? Colors.white : AppColors.grey,
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
