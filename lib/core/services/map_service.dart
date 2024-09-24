import 'package:dio/dio.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart'; // تأكد من استيراد الحزمة بشكل صحيح
import 'package:flutter/material.dart';

class MapService {
  final Location location = Location();
  final Dio dio = Dio();

  Future<LocationData> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception("Location service is disabled.");
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception("Location permission not granted.");
      }
    }
    return await location.getLocation();
  }

  Marker createMarker(double lat, double lon, String label) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(lat, lon),
      child:  Column(
        children: [
          const Icon(Icons.location_on, color: Colors.red, size: 40.0),
          Text(label, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
