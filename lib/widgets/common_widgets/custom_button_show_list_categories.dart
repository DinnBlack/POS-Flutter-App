import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../models/category_model.dart';
import '../../utils/constants/constants.dart';
import '../../utils/ui_util/app_text_style.dart';
import '../normal_widgets/custom_text_field_search_category.dart';
import 'custom_list_categories_item.dart';

class CustomButtonShowListCategories extends StatelessWidget {
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final Function(CategoryModel) onCategorySelected;

  const CustomButtonShowListCategories({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  void _showCategoriesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(DEFAULT_BORDER_RADIUS)),
            color: WHITE_COLOR,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: MEDIUM_MARGIN,
              ),
              Stack(
                children: [
                  Center(
                    child: Text(
                      'Details Menu',
                      style: AppTextStyle.semibold(
                        MEDIUM_TEXT_SIZE,
                        BLACK_TEXT_COLOR,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: DEFAULT_MARGIN,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: MEDIUM_MARGIN,
              ),
              const CustomTextFieldSearchCategory(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: DEFAULT_PADDING, right: DEFAULT_PADDING),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double itemHeight = 64;

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: DEFAULT_MARGIN,
                          mainAxisSpacing: DEFAULT_MARGIN,
                          childAspectRatio:
                              (constraints.maxWidth / 2) / itemHeight,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return SizedBox(
                            height: itemHeight,
                            child: CustomListCategoriesItem(
                              category: category,
                              isSelected: false,
                              onTap: () {
                                onCategorySelected(category);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCategoriesBottomSheet(context),
      child: Container(
        height: 60,
        width: 60,
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
