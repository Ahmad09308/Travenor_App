part of 'airport_bloc_bloc.dart';

@immutable
sealed class AirportBlocState {}

final class AirportBlocInitial extends AirportBlocState {}

final class AirportBlocLoading extends AirportBlocState {}

final class AirportBlocLoaded extends AirportBlocState {
  final List<AirportModel> airports;

  AirportBlocLoaded(this.airports);
}

final class AirportBlocError extends AirportBlocState {
  final String message;

  AirportBlocError(this.message);
}
