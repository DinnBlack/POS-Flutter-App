import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import 'package:pos_flutter_app/core/constants/constants.dart';
import '../../widget/custom_list_categories_item.dart';
import '../../../../features/category/bloc/category_bloc.dart';
import '../../model/category_model.dart';

class CategoriesListVerticalScreen extends StatefulWidget {
  final bool? isOrderPage;

  const CategoriesListVerticalScreen({super.key, this.isOrderPage});

  @override
  _CategoriesListVerticalScreenState createState() =>
      _CategoriesListVerticalScreenState();
}

class _CategoriesListVerticalScreenState
    extends State<CategoriesListVerticalScreen> {
  CategoryModel? selectedCategory;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(CategoryFetchStated());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.isOrderPage! ? kColorLightGrey : kColorWhite,
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryFetchInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryFetchSuccess) {
            final categories = state.categories;
            final selectedCategory = state.selectedCategory;
            if (categories.isEmpty) {
              return const Center(child: Text('Chưa có danh mục nào!'));
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Column(
                  children: [
                    CustomListCategoriesItem(
                      isVertical: true,
                      category: category,
                      isSelected: selectedCategory == category,
                      isOrderPage: widget.isOrderPage,
                      onTap: () {
                        if (widget.isOrderPage!) {
                          context
                              .read<CategoryBloc>()
                              .add(CategorySelectFilterStated(category));
                        }
                      },
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: kColorLightGrey.withOpacity(0.02),
                    ),
                  ],
                );
              },
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

          // Default state
          return const Center(child: Text('No categories available.'));
        },
      ),
    );
  }
}
