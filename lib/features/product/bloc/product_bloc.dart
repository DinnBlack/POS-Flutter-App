import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_app/services/firebase/product_firebase.dart';
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
      final products = await _productFirebase.fetchProducts();
      emit(ProductFetchSuccess(products));
    } catch (e) {
      emit(ProductFetchFailure(error: e.toString()));
    }
  }
}
