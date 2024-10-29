part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class AppContextState extends AppState {
  final BuildContext context;

  AppContextState(this.context);
}