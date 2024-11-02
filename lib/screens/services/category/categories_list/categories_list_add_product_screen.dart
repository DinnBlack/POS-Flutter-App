import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/widgets/normal_widgets/custom_button_add_category.dart';
import '../../../../features/category/bloc/category_bloc.dart';
import '../../../../models/category_model.dart';
import '../../../../widgets/common_widgets/custom_button_show_list_categories.dart';
import '../../../../widgets/normal_widgets/custom_list_categories_add_product_item.dart';
import '../../../../utils/constants/constants.dart';

class CategoriesListAddProductScreen extends StatefulWidget {
  const CategoriesListAddProductScreen({super.key});

  @override
  _CategoriesListAddProductScreenState createState() =>
      _CategoriesListAddProductScreenState();
}

class _CategoriesListAddProductScreenState
    extends State<CategoriesListAddProductScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(CategoryFetchStated(includeAllCategory: false));
  }

  void _onCategoryTap(CategoryModel category) {
    final isSelected = context.read<CategoryBloc>().selectedCategories.contains(category);
    if (isSelected) {
      context.read<CategoryBloc>().add(CategoryDeselectStated(category));
      print("Deselecting category: ${category.title}");
    } else {
      context.read<CategoryBloc>().add(CategorySelectStated(category));
      print("Selecting category: ${category.title}");
    }
    print(
        "Current selected categories: ${context.read<CategoryBloc>().selectedCategories}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryFetchInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryFetchSuccess) {
          final categories = state.categories;

          final selectedCategoryTitle = context.read<CategoryBloc>().selectedCategories.isNotEmpty
              ? context.read<CategoryBloc>().selectedCategories[0]
              : null;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
                  child: CustomButtonShowListCategories(
                    isAddCategory: true,
                    categories: categories,
                    selectedCategory: selectedCategoryTitle != null
                        ? categories.firstWhere(
                            (category) => category.title == selectedCategoryTitle,
                        orElse: () => categories[0]) // Fallback to first category
                        : null,
                    onCategorySelected: (category) {
                      _onCategoryTap(category);
                    },
                  ),
                ),
                Row(
                  children: List.generate(categories.length, (index) {
                    final category = categories[index];
                    final isSelected = context.read<CategoryBloc>().selectedCategories.contains(category);
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CustomListCategoriesAddProductItem(
                        category: category,
                        isSelected: isSelected,
                        onTap: () => _onCategoryTap(category),
                      ),
                    );
                  }),
                ),
                const CustomButtonAddCategory(isTitle: true),
              ],
            ),
          );
        } else if (state is CategoryFetchFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return Container();
      },
    );
  }
}
