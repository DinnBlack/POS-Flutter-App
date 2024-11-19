import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_app/features/category/bloc/category_bloc.dart';
import 'package:pos_flutter_app/features/product/data/product_firebase.dart';
import 'package:pos_flutter_app/features/category/model/category_model.dart';
import '../model/product_model.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductFirebase _productFirebase;
  List<ProductModel> allProducts = [];



  ProductBloc(this._productFirebase) : super(ProductInitial()) {
    on<ProductCreateStarted>(_onProductCreate);
    on<ProductFetchStarted>(_onProductFetch);
    on<ProductFilterChanged>(_onProductFilterChanged);
  }

  Future<void> _onProductCreate(
      ProductCreateStarted event, Emitter<ProductState> emit) async {
    emit(ProductCreateInProgress());
    try {
      await _productFirebase.addProduct(event.product);
      emit(ProductCreateSuccess());
    } catch (e) {
      emit(ProductCreateFailure(error: e.toString()));
    }
  }

  Future<void> _onProductFetch(
      ProductFetchStarted event, Emitter<ProductState> emit) async {
    emit(ProductFetchInProgress());
    try {
      allProducts = await _productFirebase.fetchProducts();
      emit(ProductFetchSuccess(allProducts));
    } catch (e) {
      emit(ProductFetchFailure(error: e.toString()));
    }
  }

  void _onProductFilterChanged(
      ProductFilterChanged event, Emitter<ProductState> emit) async {
    emit(ProductFetchInProgress());
    try {
      allProducts = await _productFirebase.fetchProducts();

      final filteredProducts = event.category.title == "Tất cả"
          ? allProducts
          : allProducts
              .where((product) =>
                  product.categories?.contains(event.category.title) ?? false)
              .toList();

      emit(ProductFetchSuccess(filteredProducts));
    } catch (e) {
      emit(ProductFetchFailure(error: e.toString()));
    }
  }
}
