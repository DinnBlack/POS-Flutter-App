import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_create_event.dart';
part 'product_create_state.dart';

class ProductCreateBloc extends Bloc<ProductCreateEvent, ProductCreateState> {
  ProductCreateBloc() : super(ProductCreateInitial()) {
    on<ProductCreateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
