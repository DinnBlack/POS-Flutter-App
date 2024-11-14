import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_app/features/order/data/order_firebase.dart';
import 'package:pos_flutter_app/models/customer_model.dart';

import '../../../models/order_model.dart';
import '../../../models/product_model.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderFirebase _orderFirebase;
  List<ProductModel> orderProductList = [];
  late OrderModel currentOrder = const OrderModel();

  int get totalProductCount => orderProductList.fold(
      0, (sum, product) => sum + (product.quantityOrder ?? 0));

  int get basePrice => orderProductList.fold(
        0,
        (sum, product) {
          int price = (product.promotionCost! > 0
              ? product.promotionCost! * (product.quantityOrder ?? 0)
              : product.price * (product.quantityOrder ?? 0));

          price -= (product.discount ?? 0);

          return sum + price;
        },
      );

  int get totalPrice {
    int discount = currentOrder.discount ?? 0;
    int surcharge = currentOrder.surcharge ?? 0;
    int shipping = currentOrder.shipping ?? 0;

    return basePrice - discount + surcharge + shipping;
  }

  OrderBloc(this._orderFirebase) : super(OrderInitial()) {
    on<OrderCreateStarted>(_onOrderCreate);
    on<OrderFetchStarted>(_onOrderFetch);
    on<AddProductToOrderListStarted>(_onAddProductToOrderList);
    on<RemoveProductFromOrderListStarted>(_onRemoveProductFromOrderList);
    on<ClearOrderProductListStarted>(_onClearOrderProductList);
    on<SetDefaultStated>(_onSetDefault);
    on<UpdateProductDetailsStarted>(_onUpdateProductDetails);
    on<UpdateOrderDetailsStarted>(_onUpdateOrderDetails);
    on<SelectCustomerStarted>(_onSelectCustomer);
    on<PrePaymentStarted>(_onPrePayment);
  }

  String _generateOrderId() {
    final now = DateTime.now();
    final datePart =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    const orderCount = '001';
    return '$datePart-$orderCount';
  }

  Future<void> _onSelectCustomer(
      SelectCustomerStarted event, Emitter<OrderState> emit) async {
    try {
      final selectedCustomer = event.customerSelect ??
          CustomerModel(name: 'Khách lẻ', phoneNumber: '');

      currentOrder = currentOrder.copyWith(
        customer: selectedCustomer,
      );

      emit(OrderUpdated(currentOrder));
      print('Selected Customer: ${selectedCustomer.name}');
    } catch (e) {
      emit(OrderUpdateFailure(error: e.toString()));
      print('Failed to select customer: $e');
    }
  }

  Future<void> _onPrePayment(
      PrePaymentStarted event, Emitter<OrderState> emit) async {
    currentOrder = currentOrder.copyWith(
      paymentStatus: event.paymentStatus,
      paidAmount: event.paidAmount,
      paymentMethod: event.paymentMethod,
    );

    emit(OrderUpdated(currentOrder));
    print(
        'Updated with pre-payment: paymentStatus=${event.paymentStatus}, paidAmount=${event.paidAmount}, paymentMethod=${event.paymentMethod}');
  }

  Future<void> _onOrderCreate(
      OrderCreateStarted event, Emitter<OrderState> emit) async {
    emit(OrderCreateInProgress());
    try {
      if (currentOrder.customer?.name == null ||
          currentOrder.customer!.name.isEmpty) {
        currentOrder = currentOrder.copyWith(
          customer: CustomerModel(name: 'Khách lẻ', phoneNumber: ''),
        );
      }

      final newOrderId = _generateOrderId();

      currentOrder = currentOrder.copyWith(
        orderId: newOrderId,
        products: orderProductList,
        totalPrice: totalPrice,
        orderTime: DateTime.now(),
        status: 'Đang xử lý',
        executor: 'User',
        paymentStatus: currentOrder.paymentStatus ?? 'Chưa thanh toán',
        paidAmount: currentOrder.paidAmount ?? 0,
        paymentMethod: currentOrder.paymentMethod ?? 'Tiền mặt',
      );

      await _orderFirebase.createOrder(currentOrder);
      print('New Order: $currentOrder');

      emit(OrderCreateSuccess());
    } catch (e) {
      emit(OrderCreateFailure(error: e.toString()));
      print('Failed to create order: $e');
    }
  }

  Future<void> _onOrderFetch(
      OrderFetchStarted event, Emitter<OrderState> emit) async {
    emit(OrderFetchInProgress());
    try {
      List<OrderModel> fetchedOrders = await _orderFirebase.fetchOrders();
      if (event.status != null && event.status!.isNotEmpty) {
        fetchedOrders = fetchedOrders
            .where((order) => order.status == event.status)
            .toList();
      }
      if (event.sortBy != null) {
        switch (event.sortBy) {
          case 'newest':
            fetchedOrders.sort((a, b) => (b.orderTime ?? DateTime(0))
                .compareTo(a.orderTime ?? DateTime(0)));
            break;
          case 'oldest':
            fetchedOrders.sort((a, b) => (a.orderTime ?? DateTime(0))
                .compareTo(b.orderTime ?? DateTime(0)));
            break;
          case 'highest_price':
            fetchedOrders.sort(
                (a, b) => (b.totalPrice ?? 0).compareTo(a.totalPrice ?? 0));
            break;
          case 'lowest_price':
            fetchedOrders.sort(
                (a, b) => (a.totalPrice ?? 0).compareTo(b.totalPrice ?? 0));
            break;
          default:
            fetchedOrders.sort((a, b) => (b.orderTime ?? DateTime(0))
                .compareTo(a.orderTime ?? DateTime(0)));
            break;
        }
      } else {
        fetchedOrders.sort((a, b) =>
            (b.orderTime ?? DateTime(0)).compareTo(a.orderTime ?? DateTime(0)));
      }

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
      orderProductList[index].quantityOrder =
          (orderProductList[index].quantityOrder ?? 0) + 1;
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

  Future<void> _onSetDefault(
      SetDefaultStated event, Emitter<OrderState> emit) async {
    orderProductList.clear();
    currentOrder = const OrderModel();
    print("Current Order: $currentOrder");
    emit(SetDefaultState(orderProductList, currentOrder));
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
    // Prepare the updates map
    Map<String, dynamic> updates = {};
    if (event.newTotalPrice != null) {
      updates['totalPrice'] = event.newTotalPrice;
    }
    if (event.newCustomer != null) {
      updates['customerName'] = event.newCustomer;
    }
    if (event.newOrderTime != null) {
      updates['orderTime'] = event.newOrderTime?.toIso8601String();
    }
    if (event.newStatus != null) updates['status'] = event.newStatus;
    if (event.newExecutor != null) updates['executor'] = event.newExecutor;
    if (event.newPaymentStatus != null) {
      updates['paymentStatus'] = event.newPaymentStatus;
    }
    if (event.newNote != null) updates['note'] = event.newNote;
    if (event.newPaymentMethod != null) {
      updates['paymentMethod'] = event.newPaymentMethod;
    }
    if (event.newDiscount != null) updates['discount'] = event.newDiscount;
    if (event.newShipping != null) updates['shipping'] = event.newShipping;
    if (event.newSurcharge != null) updates['surcharge'] = event.newSurcharge;
    if (event.newPaidAmount != null)
      updates['paidAmount'] = event.newPaidAmount;

    try {
      if (event.orderId != null) {
        await _orderFirebase.updateOrder(event.orderId!, updates);
        print('Updated order in Firebase: $updates');

        emit(OrderFetchInProgress());
        final fetchedOrders = await _orderFirebase.fetchOrders();
        final updatedOrder =
            fetchedOrders.firstWhere((order) => order.orderId == event.orderId);
        emit(OrderFetchSuccess(orders: fetchedOrders));
        print('Fetched Updated Order: $updatedOrder');
      } else {
        currentOrder = currentOrder.copyWith(
          totalPrice: event.newTotalPrice,
          customer: event.newCustomer,
          orderTime: event.newOrderTime,
          status: event.newStatus,
          executor: event.newExecutor,
          paymentStatus: event.newPaymentStatus,
          note: event.newNote,
          paymentMethod: event.newPaymentMethod,
          discount: event.newDiscount,
          shipping: event.newShipping,
          surcharge: event.newSurcharge,
          paidAmount: event.newPaidAmount,
        );
        emit(OrderUpdated(currentOrder));
        print('Updated currentOrder: $currentOrder');
      }
    } catch (error) {
      emit(OrderUpdateFailure(error: error.toString()));
      print('Failed to update order: $error');
    }
  }
}
