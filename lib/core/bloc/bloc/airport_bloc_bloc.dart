// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travenor_app/core/model/AirportModel.dart';
import 'package:travenor_app/core/services/AirportApi.dart';

part 'airport_bloc_event.dart';
part 'airport_bloc_state.dart';

class AirportBlocBloc extends Bloc<AirportBlocEvent, AirportBlocState> {
  final AirportService airportService;

  AirportBlocBloc({required this.airportService}) : super(AirportBlocInitial()) {
    on<FetchAirportsEvent>((event, emit) async {
      emit(AirportBlocLoading());
      try {
        final List<AirportModel> airports = await airportService.getAllAirports();
        emit(AirportBlocLoaded(airports));
      } catch (e) {
        emit(AirportBlocError(e.toString()));
      }
    });
  }
}
