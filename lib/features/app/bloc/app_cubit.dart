import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  void saveContext(BuildContext context) {
    emit(AppContextState(context));
  }

  BuildContext? getContext() {
    if (state is AppContextState) {
      return (state as AppContextState).context;
    }
    return null;
  }
}
