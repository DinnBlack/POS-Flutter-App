import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_app/services/firebase/store_firebase.dart';
import '../../../../models/store_model.dart';

part 'store_event.dart';

part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreFirebase _storeFirebase;

  StoreBloc(this._storeFirebase) : super(StoreInitial()) {
    on<StoreCreateStated>(_onCreateStore);
    on<StoreSelectStated>(_onSelectStore);
  }

  Future<void> _onCreateStore(
      StoreCreateStated event, Emitter<StoreState> emit) async {
    emit(StoreCreateInProgress());
    try {
      final newStore = StoreModel(
        name: event.storeName,
        businessType: event.businessType,
        createdAt: DateTime.now(),
      );

      await _storeFirebase.createStore(newStore);

      emit(StoreCreateSuccess());
    } catch (e) {
      emit(StoreCreateFailure(error: e.toString()));
    }
  }

  Future<void> _onSelectStore(
      StoreSelectStated event, Emitter<StoreState> emit) async {
    emit(StoreSelectInProgress());
    try {
      // Fetch the list of stores for the user from Firebase
      List<StoreModel> stores = await _storeFirebase.fetchUserStores();
      emit(StoreSelectSuccess(stores: stores));
    } catch (e) {
      emit(StoreSelectFailure(error: e.toString()));
    }
  }
}
