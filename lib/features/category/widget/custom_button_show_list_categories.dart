import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';

import '../model/category_model.dart';
import '../screen/dialog/list_categories_bottom_sheet.dart';

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
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: kColorLightGrey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(kBorderRadiusMd),
        ),
        child: const Icon(Iconsax.menu),
      ),
    );
  }
}
