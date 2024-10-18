import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_order_event.dart';
part 'product_order_state.dart';

class ProductOrderBloc extends Bloc<ProductOrderEvent, ProductOrderState> {
  ProductOrderBloc() : super(ProductOrderInitial()) {
    on<ProductOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
