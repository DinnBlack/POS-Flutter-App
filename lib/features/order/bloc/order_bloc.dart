import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_app/features/order/data/order_firebase.dart';

import '../../../models/order_model.dart';
import '../../../models/product_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderFirebase _orderFirebase;
  List<ProductModel> orderProductList = [];

  OrderBloc(this._orderFirebase) : super(OrderInitial()) {
    on<OrderCreateStarted>(_onOrderCreate);
    on<AddProductToOrderListStarted>(_onAddProductToOrderList);
    on<RemoveProductFromOrderListStarted>(_onRemoveProductFromOrderList);
    on<ClearOrderProductListStarted>(_onClearOrderProductList);
  }

  Future<void> _onOrderCreate(
      OrderCreateStarted event, Emitter<OrderState> emit) async {
    emit(OrderCreateInProgress());
    try {
      await _orderFirebase.createOrder(event.order);

      emit(OrderCreateSuccess());
    } catch (e) {
      emit(OrderCreateFailure(error: e.toString()));
    }
  }

  Future<void> _onAddProductToOrderList(
      AddProductToOrderListStarted event, Emitter<OrderState> emit) async {
    final index = orderProductList.indexWhere((product) =>
    product.title == event.product.title &&
        product.options == event.product.options &&
        product.price == event.product.price);

    if (index != -1) {
      if (orderProductList[index].quantityOrder != null) {
        orderProductList[index].quantityOrder =
            (orderProductList[index].quantityOrder ?? 0) + 1;
      }
    } else {
      final newProduct = event.product.copyWith(quantityOrder: 1);
      orderProductList.add(newProduct);
    }
    emit(OrderProductListUpdated(orderProductList));
    print(orderProductList);
  }

  Future<void> _onRemoveProductFromOrderList(
      RemoveProductFromOrderListStarted event, Emitter<OrderState> emit) async {
    final index = orderProductList.indexWhere((product) =>
    product.title == event.product.title &&
        product.options == event.product.options &&
        product.price == event.product.price);

    if (index != -1) {
      if ((orderProductList[index].quantityOrder ?? 1) > 1) {
        orderProductList[index].quantityOrder =
            (orderProductList[index].quantityOrder ?? 1) - 1;
      } else {
        orderProductList.removeAt(index);
      }
    }
    emit(OrderProductListUpdated(orderProductList));
    print(orderProductList);
  }

  Future<void> _onClearOrderProductList(
      ClearOrderProductListStarted event, Emitter<OrderState> emit) async {
    orderProductList.clear();
    print("List: $orderProductList");
    emit(OrderProductListUpdated(orderProductList));
  }
}
