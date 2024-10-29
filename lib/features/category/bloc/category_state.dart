part of 'category_bloc.dart';

@immutable
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryFetchInProgress extends CategoryState {}

class CategoryFetchSuccess extends CategoryState {
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final List<CategoryModel> selectedCategories;

  CategoryFetchSuccess({
    required this.categories,
    this.selectedCategory,
    required this.selectedCategories,
  });

  @override
  List<Object?> get props =>
      [categories, selectedCategory, selectedCategories];
}

class CategoryFetchFailure extends CategoryState {
  final String error;

  CategoryFetchFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class CategoryCreateInProgress extends CategoryState {}

class CategoryCreateSuccess extends CategoryState {}

class CategoryCreateFailure extends CategoryState {
  final String error;

  CategoryCreateFailure({required this.error});
}

class CategorySelectionState extends CategoryState {
  final List<CategoryModel> selectedCategories;

  CategorySelectionState(this.selectedCategories);

  @override
  List<Object> get props => [selectedCategories];
}

class CategorySelectFilterState extends CategoryState {
  final CategoryModel selectedCategory;

  CategorySelectFilterState(this.selectedCategory);

  @override
  List<Object> get props => [selectedCategory];
}
