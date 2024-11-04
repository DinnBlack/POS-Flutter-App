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
  late OrderModel currentOrder = OrderModel(orderId: '');

  int get totalProductCount => orderProductList.fold(
      0, (sum, product) => sum + (product.quantityOrder ?? 0));

  int get totalPrice => orderProductList.fold(
        0,
        (sum, product) =>
            sum +
            ((product.promotionCost! > 0
                    ? product.promotionCost! * (product.quantityOrder ?? 0)
                    : product.price * (product.quantityOrder ?? 0)) -
                (product.discount ?? 0)),
      );

  OrderBloc(this._orderFirebase) : super(OrderInitial()) {
    on<OrderCreateStarted>(_onOrderCreate);
    on<OrderFetchStarted>(_onOrderFetch);
    on<AddProductToOrderListStarted>(_onAddProductToOrderList);
    on<RemoveProductFromOrderListStarted>(_onRemoveProductFromOrderList);
    on<ClearOrderProductListStarted>(_onClearOrderProductList);
    on<UpdateProductDetailsStarted>(_onUpdateProductDetails);
    on<UpdateOrderDetailsStarted>(_onUpdateOrderDetails);
  }

  String _generateOrderId() {
    final now = DateTime.now();
    final datePart =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    const orderCount = '001';
    return '$datePart-$orderCount';
  }

  Future<void> _onOrderCreate(
      OrderCreateStarted event, Emitter<OrderState> emit) async {
    emit(OrderCreateInProgress());
    try {
      final newOrderId = _generateOrderId();

      currentOrder = currentOrder.copyWith(
        orderId: newOrderId,
        products: orderProductList,
        totalPrice: totalPrice,
        customerName: 'Khách lẻ',
        orderTime: DateTime.now(),
        status: 'Đang xử lý',
        executor: 'User',
        paymentStatus: true,
      );

      await _orderFirebase.createOrder(currentOrder);

      emit(OrderCreateSuccess());
      print('New Order: $currentOrder');
    } catch (e) {
      emit(OrderCreateFailure(error: e.toString()));
      print('Failed to create order: $e');
    }
  }

  Future<void> _onOrderFetch(OrderFetchStarted event, Emitter<OrderState> emit) async {
    emit(OrderFetchInProgress());
    try {
      final fetchedOrders = await _orderFirebase.fetchOrders();
      emit(OrderFetchSuccess(orders: fetchedOrders));
      print('Fetched Orders: $fetchedOrders');
    } catch (e) {
      emit(OrderFetchFailure(error: e.toString()));
      print('Failed to fetch orders: $e');
    }
  }

  Future<void> _onAddProductToOrderList(
      AddProductToOrderListStarted event, Emitter<OrderState> emit) async {
    final index = orderProductList
        .indexWhere((product) => product.title == event.product.title);

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
        product.price == event.product.price);

    if (event.isRemoved!) {
      if (index != -1) {
        orderProductList.removeAt(index);
      }
    } else {
      if (index != -1) {
        if ((orderProductList[index].quantityOrder ?? 1) > 1) {
          orderProductList[index].quantityOrder =
              (orderProductList[index].quantityOrder ?? 1) - 1;
        } else {
          orderProductList.removeAt(index);
        }
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

  Future<void> _onUpdateProductDetails(
      UpdateProductDetailsStarted event, Emitter<OrderState> emit) async {
    final index = orderProductList
        .indexWhere((product) => product.title == event.product.title);

    if (index != -1) {
      orderProductList[index] = orderProductList[index].copyWith(
        price: (orderProductList[index].promotionCost != null &&
                orderProductList[index].promotionCost! > 0)
            ? orderProductList[index].price
            : event.newPrice ?? orderProductList[index].price,
        promotionCost: (orderProductList[index].promotionCost != null &&
                orderProductList[index].promotionCost! > 0)
            ? event.newPrice ?? orderProductList[index].promotionCost
            : orderProductList[index].promotionCost,
        note: event.newNote ?? orderProductList[index].note,
        discount: event.newDiscount ?? orderProductList[index].discount,
      );
    }

    emit(OrderProductListUpdated(orderProductList));
    print('update  $orderProductList');
  }

  Future<void> _onUpdateOrderDetails(
      UpdateOrderDetailsStarted event, Emitter<OrderState> emit) async {
    currentOrder = currentOrder.copyWith(
      totalPrice: event.newTotalPrice,
      customerName: event.newCustomerName,
      orderTime: event.newOrderTime,
      status: event.newStatus,
      executor: event.newExecutor,
      paymentStatus: event.newPaymentStatus,
      note: event.newNote,
      paymentMethod: event.newPaymentMethod,
    );

    emit(OrderUpdated(currentOrder));
    print('Updated Order: $currentOrder');
  }
}
