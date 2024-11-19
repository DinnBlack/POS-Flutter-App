import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/widgets/common_widgets/custom_text_field.dart';
import '../../widget/custom_list_categories_item.dart';
import '../../widget/custom_button_add_category.dart';
import '../../model/category_model.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../features/category/bloc/category_bloc.dart';

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
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(kBorderRadiusMd)),
          color: kColorWhite,
        ),
        child: Column(
          children: [
            const SizedBox(height: kMarginMd),
            Stack(
              children: [
                Center(
                  child: Text(
                    'Danh Mục',
                    style: AppTextStyle.semibold(kTextSizeMd),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: kMarginMd,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kMarginMd),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: CustomTextField(hintText: '')),
                if (isAddCategory!)
                  GestureDetector(
                    onTap: () {
                      _addCategory(context);
                    },
                    child: const CustomButtonAddCategory(),
                  ),
                if (isAddCategory!) const SizedBox(width: kMarginMd),
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: kPaddingMd, right: kPaddingMd),
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
                              crossAxisSpacing: kMarginMd,
                              mainAxisSpacing: kMarginMd,
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
