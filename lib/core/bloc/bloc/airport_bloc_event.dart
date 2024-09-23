part of 'airport_bloc_bloc.dart';

@immutable
abstract class AirportBlocEvent {}

class FetchAirportsEvent extends AirportBlocEvent {}

class SearchAirportsEvent extends AirportBlocEvent {
  final String query;

  SearchAirportsEvent(this.query);
}

class ClearSearchEvent extends AirportBlocEvent {} 
