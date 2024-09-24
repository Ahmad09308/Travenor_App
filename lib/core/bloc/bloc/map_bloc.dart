import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:travenor_app/core/services/map_service.dart'; // تأكد من استيراد MapService

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapService mapService; // إضافة MapService

  MapBloc({required this.mapService}) : super(MapInitial()) {
    on<GetLocationEvent>(_getLocation); // التعامل مع الحدث GetLocationEvent
  }

  Future<void> _getLocation(GetLocationEvent event, Emitter<MapState> emit) async {
    emit(MapLoading());
    try {
      var userLocation = await mapService.getCurrentLocation(); // الحصول على الموقع الحالي
      List<Marker> markers = [
        mapService.createMarker(
          userLocation.latitude!,
          userLocation.longitude!,
          'My Location',
        )
      ];
      emit(MapLoaded(userLocation, markers)); // إرسال الحالة بعد تحميل الموقع والعلامات
    } catch (e) {
      emit(MapError('Error getting location: $e')); // التعامل مع الخطأ
    }
  }
}
