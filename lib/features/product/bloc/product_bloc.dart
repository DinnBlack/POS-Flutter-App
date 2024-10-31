import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_app/features/category/bloc/category_bloc.dart';
import 'package:pos_flutter_app/features/product/data/product_firebase.dart';
import 'package:pos_flutter_app/models/category_model.dart';
import '../../../models/product_model.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductFirebase _productFirebase;

  ProductBloc(this._productFirebase) : super(ProductInitial()) {
    on<ProductCreateStarted>(_onProductCreate);
    on<ProductFetchStarted>(_onProductFetch);
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
      List<ProductModel> products;

      if (event.category.title == "Tất cả") {
        products = await _productFirebase.fetchProducts();
      } else {
        products =
            await _productFirebase.fetchProductsByCategory(event.category);
      }

      emit(ProductFetchSuccess(products));
    } catch (e) {
      emit(ProductFetchFailure(error: e.toString()));
    }
  }
}
