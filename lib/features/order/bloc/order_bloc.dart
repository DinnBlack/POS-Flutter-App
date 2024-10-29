import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_app/features/order/data/order_firebase.dart';

import '../../../models/order_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderFirebase _orderFirebase;
  OrderBloc(this._orderFirebase) : super(OrderInitial()) {
    on<OrderCreateStarted>(_onOrderCreate);
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
}
