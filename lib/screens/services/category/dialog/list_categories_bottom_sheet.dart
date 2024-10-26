import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/widgets/common_widgets/custom_button.dart';
import '../../../../models/category_model.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/ui_util/app_text_style.dart';
import '../../../../widgets/common_widgets/custom_list_categories_item.dart';
import '../../../../widgets/normal_widgets/custom_button_add_category.dart';
import '../../../../widgets/normal_widgets/custom_text_field_search_category.dart';
import '../../../../features/category/bloc/category_bloc.dart'; // Import Bloc

void showListCategoriesBottomSheet(
  BuildContext context,
  CategoryModel? selectedCategory,
  Function(CategoryModel) onCategorySelected,
  bool? isAddCategory,
) {
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
            const SizedBox(height: MEDIUM_MARGIN),
            Stack(
              children: [
                Center(
                  child: Text(
                    'Danh Mục',
                    style: AppTextStyle.semibold(
                        MEDIUM_TEXT_SIZE, BLACK_TEXT_COLOR),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: DEFAULT_MARGIN,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
            const SizedBox(height: MEDIUM_MARGIN),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: CustomTextFieldSearchCategory()),
                if (isAddCategory!)
                  GestureDetector(
                    onTap: () {
                      _addCategory(context);
                    },
                    child: const CustomButtonAddCategory(),
                  ),
                if (isAddCategory!) const SizedBox(width: DEFAULT_MARGIN),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: DEFAULT_PADDING, right: DEFAULT_PADDING),
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryFetchInProgress) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CategoryFetchSuccess) {
                      final categories = state.categories;

                      return LayoutBuilder(
                        builder: (context, constraints) {
                          double itemHeight = 64;

                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                  isSelected: selectedCategory == category,
                                  onTap: () {
                                    onCategorySelected(category);
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else if (state is CategoryCreateFailure) {
                      return Center(child: Text('Error: ${state.error}'));
                    }

                    return const Center(
                        child: Text('No categories available.'));
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

void _addCategory(BuildContext context) {
  context.read<CategoryBloc>().add(CategoryFetchStated());
}
