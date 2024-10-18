import 'package:flutter/material.dart';
import '../../../database/db_categories.dart';
import '../../../widgets/common_widgets/custom_list_categories_item.dart';
import '../../../models/category_model.dart';

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
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: Row(
            children: List.generate(categories.length, (index) {
              final category = categories[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: index == categories.length - 1 ? 10 : 0,
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
      ],
    );
  }
}
