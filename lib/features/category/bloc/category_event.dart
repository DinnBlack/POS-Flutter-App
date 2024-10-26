part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class CategoryFetchStated extends CategoryEvent {
  final bool includeAllCategory;

  CategoryFetchStated({this.includeAllCategory = true});
}

class CategoryCreateStated extends CategoryEvent {
  final String title;

  CategoryCreateStated(this.title);
}

class CategorySelectStated extends CategoryEvent {
  final CategoryModel category;

  CategorySelectStated(this.category);
}

class CategoryDeselectStated extends CategoryEvent {
  final CategoryModel category;

  CategoryDeselectStated(this.category);
}

class CategoryClearSelectionStated extends CategoryEvent {
  final bool isAddProductPage;

  CategoryClearSelectionStated({this.isAddProductPage = false});
}

class CategorySelectFilterStated extends CategoryEvent {
  final CategoryModel selectedCategory;

  CategorySelectFilterStated(this.selectedCategory);
}

class CategoryResetToDefaultStated extends CategoryEvent {}
