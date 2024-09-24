// ignore_for_file: override_on_non_overriding_member

part of 'map_bloc.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class MapLoaded extends MapState {
  final LocationData locationData; 
  final List<Marker> markers; 

  MapLoaded(this.locationData, this.markers);

  @override
  List<Object?> get props => [locationData, markers];
}

final class MapError extends MapState {
  final String message; // رسالة الخطأ

  MapError(this.message);

  @override
  List<Object?> get props => [message];
}
