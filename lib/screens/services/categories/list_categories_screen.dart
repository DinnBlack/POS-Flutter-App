import 'package:flutter/material.dart';
import '../../../database/db_categories.dart';
import '../../../widgets/common_widgets/custom_list_categories_item.dart';
import '../../../models/category_model.dart';

class ListCategoriesScreen extends StatefulWidget {
  const ListCategoriesScreen({super.key});

  @override
  _ListCategoriesScreenState createState() =>
      _ListCategoriesScreenState();
}

class _ListCategoriesScreenState
    extends State<ListCategoriesScreen> {
  CategoryModel? selectedCategory;
  final ScrollController _scrollController = ScrollController();
  bool canScrollLeft = false;
  bool canScrollRight = false;

  final double categoryItemWidth = 120;
  double availableWidth = 0;

  void _scrollLeft() {
    final scrollAmount = availableWidth;
    _scrollController.animateTo(
      _scrollController.offset - scrollAmount,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    final scrollAmount = availableWidth;
    _scrollController.animateTo(
      _scrollController.offset + scrollAmount,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        canScrollLeft = _scrollController.offset > 0;
        canScrollRight = _scrollController.offset <
            _scrollController.position.maxScrollExtent;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        availableWidth = MediaQuery.of(context).size.width - 80;
        canScrollRight = _scrollController.position.maxScrollExtent > 0;
      });
    });
  }

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
                  right: index == categories.length - 1
                      ? 10
                      : 0,
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
