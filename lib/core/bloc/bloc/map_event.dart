part of 'map_bloc.dart';

@immutable
sealed class MapEvent {}

final class GetLocationEvent extends MapEvent {} // إضافة حدث GetLocationEvent
