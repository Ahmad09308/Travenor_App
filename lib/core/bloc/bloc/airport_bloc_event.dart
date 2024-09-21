part of 'airport_bloc_bloc.dart';

@immutable
sealed class AirportBlocEvent {}

class FetchAirportsEvent extends AirportBlocEvent {}
