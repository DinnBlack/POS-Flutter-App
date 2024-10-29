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
  List<ProductModel> orderProductList = [];

  ProductBloc(this._productFirebase) : super(ProductInitial()) {
    on<ProductCreateStarted>(_onProductCreate);
    on<ProductFetchStarted>(_onProductFetch);
    on<AddProductToOrderList>(_onAddProductToOrderList);
    on<RemoveProductFromOrderList>(_onRemoveProductFromOrderList);
    on<ClearOrderProductList>(_onClearOrderProductList);
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
      print('fetch rồi');
    } catch (e) {
      emit(ProductFetchFailure(error: e.toString()));
    }
  }

  Future<void> _onAddProductToOrderList(
      AddProductToOrderList event, Emitter<ProductState> emit) async {
    print("Vừa thêm order: ${event.product}");
    orderProductList.add(event.product);
    print("List: $orderProductList");
    emit(ProductOrderListUpdated(orderProductList));
  }

  Future<void> _onRemoveProductFromOrderList(
      RemoveProductFromOrderList event, Emitter<ProductState> emit) async {
    orderProductList.remove(event.product);
    emit(ProductOrderListUpdated(orderProductList));
  }

  Future<void> _onClearOrderProductList(
      ClearOrderProductList event, Emitter<ProductState> emit) async {
    orderProductList.clear();
    print("List: $orderProductList");
    emit(ProductOrderListUpdated(orderProductList));
  }
}
