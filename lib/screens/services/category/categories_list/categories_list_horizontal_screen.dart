import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/category/bloc/category_bloc.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';

import '../../../../widgets/common_widgets/custom_button_show_list_categories.dart';
import '../../../../widgets/common_widgets/custom_list_categories_item.dart';

class CategoriesListHorizontalScreen extends StatefulWidget {
  const CategoriesListHorizontalScreen({super.key});

  @override
  _CategoriesListHorizontalScreenState createState() =>
      _CategoriesListHorizontalScreenState();
}

class _CategoriesListHorizontalScreenState
    extends State<CategoriesListHorizontalScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(CategoryFetchStated(includeAllCategory: true));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryFetchInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryFetchSuccess) {
          final categories = state.categories;
          final selectedCategory = state.selectedCategory;

          return Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children: [
                  Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
                    child: CustomButtonShowListCategories(
                      categories: categories,
                      selectedCategory: selectedCategory,
                      onCategorySelected: (category) {
                        context
                            .read<CategoryBloc>()
                            .add(CategorySelectFilterStated(category));
                      },
                    ),
                  ),
                  Row(
                    children: List.generate(categories.length, (index) {
                      final category = categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CustomListCategoriesItem(
                          category: category,
                          isSelected: selectedCategory == category,
                          onTap: () {
                            context
                                .read<CategoryBloc>()
                                .add(CategorySelectFilterStated(category));
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        } else if (state is CategoryFetchFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.error}'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<CategoryBloc>().add(CategoryFetchStated());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return const Center(child: Text('No categories available.'));
      },
    );
  }
}

