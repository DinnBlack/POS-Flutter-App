import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_app/features/category/data/category_firebase.dart';
import '../../../models/category_model.dart';
import '../../product/bloc/product_bloc.dart';

part 'category_event.dart';

part 'category_state.dart';

const CategoryModel defaultCategory = CategoryModel(title: 'Tất cả', count: 40);

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryFirebase _categoryFirebase;
  final ProductBloc _productBloc;
  List<CategoryModel> addProductCategories = [];
  List<CategoryModel> selectedCategories = [];
  List<CategoryModel> categories = [];
  CategoryModel? selectedCategory = defaultCategory;

  List<String> get selectedCategoriesTitle =>
      selectedCategories.map((category) => category.title).toList();

  CategoryBloc(this._categoryFirebase, this._productBloc)
      : super(CategoryInitial()) {
    on<CategoryFetchStated>(_onCategoryFetch);
    on<CategoryCreateStated>(_onCategoryCreate);
    on<CategorySelectStated>(_onCategorySelect);
    on<CategoryDeselectStated>(_onCategoryDeselect);
    on<CategoryClearSelectionStated>(_onCategoryClearSelection);
    on<CategorySelectFilterStated>(_onCategorySelectFilter);
    on<CategoryResetToDefaultStated>(_onCategoryResetToDefault);
  }

  Future<void> _onCategoryFetch(
      CategoryFetchStated event, Emitter<CategoryState> emit) async {
    emit(CategoryFetchInProgress());
    try {
      categories = await _categoryFirebase.fetchCategories();
      categories.insert(0, const CategoryModel(title: 'Tất cả', count: 40));
      addProductCategories = categories.skip(1).toList();
      emit(CategoryFetchSuccess(
        categories:
            event.includeAllCategory ? categories : addProductCategories,
        selectedCategory: selectedCategory,
        selectedCategories: selectedCategories,
      ));
    } catch (e) {
      emit(CategoryFetchFailure(error: e.toString()));
    }
  }

  Future<void> _onCategoryCreate(
      CategoryCreateStated event, Emitter<CategoryState> emit) async {
    emit(CategoryCreateInProgress());
    try {
      await _categoryFirebase.createCategory(event.title);
      emit(CategoryCreateSuccess());
      add(CategoryFetchStated());
    } catch (e) {
      emit(CategoryCreateFailure(error: e.toString()));
    }
  }

  Future<void> _onCategorySelect(
      CategorySelectStated event, Emitter<CategoryState> emit) async {
    selectedCategories.add(event.category);
    print("Selected categories after adding: $selectedCategories");
    print("Selected categories after removing: $selectedCategoriesTitle");
    emit(CategorySelectionState(selectedCategories));
    emit(CategoryFetchSuccess(
        categories: addProductCategories,
        selectedCategory: selectedCategory,
        selectedCategories: selectedCategories));
  }

  Future<void> _onCategoryDeselect(
      CategoryDeselectStated event, Emitter<CategoryState> emit) async {
    selectedCategories.remove(event.category);
    print("Selected categories after removing: $selectedCategories");
    print("Selected categories after removing: $selectedCategoriesTitle");
    emit(CategorySelectionState(selectedCategories));
    emit(CategoryFetchSuccess(
        categories: addProductCategories,
        selectedCategory: selectedCategory,
        selectedCategories: selectedCategories));
  }

  Future<void> _onCategoryClearSelection(
      CategoryClearSelectionStated event, Emitter<CategoryState> emit) async {
    print("CategoryClearSelectionStated event triggered");
    selectedCategories.clear();
    emit(CategorySelectionState(selectedCategories));
    emit(CategoryFetchSuccess(
        categories: event.isAddProductPage ? addProductCategories : categories,
        selectedCategory: selectedCategory,
        selectedCategories: selectedCategories));
  }

  void _onCategorySelectFilter(
      CategorySelectFilterStated event, Emitter<CategoryState> emit) {
    selectedCategory = event.selectedCategory;
    emit(CategoryFetchSuccess(
        categories: categories,
        selectedCategory: selectedCategory,
        selectedCategories: selectedCategories));
    _productBloc.add(ProductFilterChanged(selectedCategory!));
    print('dang chon $selectedCategory');
  }

  Future<void> _onCategoryResetToDefault(
      CategoryResetToDefaultStated event, Emitter<CategoryState> emit) async {
    selectedCategory = defaultCategory;
    print('chon $selectedCategory');

    emit(CategoryFetchSuccess(
      categories: categories,
      selectedCategory: selectedCategory,
      selectedCategories: selectedCategories,
    ));
  }

}
