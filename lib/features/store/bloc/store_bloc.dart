import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pos_flutter_app/services/firebase/store_firebase.dart';
import '../../../../models/store_model.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreFirebase _storeFirebase;
  StoreModel? _selectedStore;

  StoreBloc(this._storeFirebase) : super(StoreInitial()) {
    on<StoreCreateStated>(_onCreateStore);
    on<StoreFetchStated>(_onFetchStores);
    on<StoreSelectStated>(_onSelectStore);
  }

  // Create a new store
  Future<void> _onCreateStore(
      StoreCreateStated event, Emitter<StoreState> emit) async {
    emit(StoreCreateInProgress());
    try {
      if (event.storeName.isEmpty || event.businessType.isEmpty) {
        emit(StoreCreateFailure(error: "Store name and business type are required."));
        return;
      }

      final newStore = StoreModel(
        id: "",
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

  // Fetch all stores for the user
  Future<void> _onFetchStores(
      StoreFetchStated event, Emitter<StoreState> emit) async {
    emit(StoreFetchInProgress());
    try {
      List<StoreModel> stores = await _storeFirebase.fetchUserStores();
      emit(StoreFetchSuccess(stores: stores));
    } catch (e) {
      emit(StoreFetchFailure(error: e.toString()));
    }
  }

  // Select a store for further operations
  Future<void> _onSelectStore(
      StoreSelectStated event, Emitter<StoreState> emit) async {
    emit(StoreSelectInProgress());
    if (event.store != null) {
      _selectedStore = event.store;
      emit(StoreSelected(selectedStore: _selectedStore!));
    } else {
      emit(StoreSelectFailure(error: "No store selected."));
    }
  }

  StoreModel? get selectedStore => _selectedStore;
}
