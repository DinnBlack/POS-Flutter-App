import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/screens/services/category/dialog/list_categories_bottom_sheet.dart';

import '../../models/category_model.dart';
import '../../utils/constants/constants.dart';

class CustomButtonShowListCategories extends StatelessWidget {
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final Function(CategoryModel) onCategorySelected;
  final bool? isAddCategory;

  const CustomButtonShowListCategories({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    this.isAddCategory = false,
  });

  void _showListCategoriesBottomSheet(BuildContext context) {
    showListCategoriesBottomSheet(
      context,
      selectedCategory,
      onCategorySelected,
      isAddCategory,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showListCategoriesBottomSheet(context),
      child: Container(
        height: isAddCategory! ? 40 : 60,
        width: isAddCategory! ? 40 : 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: GREY_LIGHT_COLOR,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
        ),
        child: const Icon(Iconsax.menu),
      ),
    );
  }
}
