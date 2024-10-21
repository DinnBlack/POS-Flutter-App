import 'package:flutter/material.dart';
import '../../../database/db_categories.dart';
import '../../../widgets/common_widgets/custom_button_show_list_categories.dart';
import '../../../widgets/common_widgets/custom_list_categories_item.dart';
import '../../../models/category_model.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';

class ListCategoriesScreen extends StatefulWidget {
  const ListCategoriesScreen({super.key});

  @override
  _ListCategoriesScreenState createState() => _ListCategoriesScreenState();
}

class _ListCategoriesScreenState extends State<ListCategoriesScreen> {
  CategoryModel? selectedCategory;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: DEFAULT_MARGIN),
        CustomButtonShowListCategories(
          categories: categories,
          selectedCategory: selectedCategory,
          onCategorySelected: (category) {
            setState(() {
              selectedCategory = category;
            });
          },
        ),
        const SizedBox(width: DEFAULT_MARGIN),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: Row(
              children: List.generate(categories.length, (index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: CustomListCategoriesItem(
                    category: category,
                    isSelected: selectedCategory == category,
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
