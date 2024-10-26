import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/category/bloc/category_bloc.dart';
import '../../../widgets/common_widgets/custom_list_categories_item.dart';
import '../../../models/category_model.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';

class ListCategoriesVerticalScreen extends StatefulWidget {
  const ListCategoriesVerticalScreen({super.key});

  @override
  _ListCategoriesVerticalScreenState createState() =>
      _ListCategoriesVerticalScreenState();
}

class _ListCategoriesVerticalScreenState
    extends State<ListCategoriesVerticalScreen> {
  CategoryModel? selectedCategory;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch categories when the screen initializes
    context.read<CategoryBloc>().add(CategoryFetchStated());
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
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: GREY_LIGHT_COLOR.withOpacity(0.02),
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
    );
  }
}
