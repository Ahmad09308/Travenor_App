// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travenor_app/Auth/view/widget/MapWidget.dart';
import 'package:travenor_app/core/bloc/bloc/airport_bloc_bloc.dart';
import 'package:travenor_app/core/model/AirportModel.dart';

class MapScreen extends StatelessWidget {
  final AirportModel airport;

  const MapScreen({super.key, required this.airport});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AirportBlocBloc, AirportBlocState>(
          builder: (context, state) {
            if (state is AirportBlocLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AirportBlocLoaded) {
              final List<AirportModel> airports = state.airports;

              // فلترة المطارات من المطار الذي تم تحديده على الخريطة
              final List<AirportModel> nearbyAirports =
                  airports.where((otherAirport) {
                final distance = _calculateDistance(
                  airport.location.latitude,
                  airport.location.longitude,
                  otherAirport.location.latitude,
                  otherAirport.location.longitude,
                );
                return distance < 50.0 && otherAirport.id != airport.id;
              }).toList();

              // كود للمطارات القريبة
              final List<AirportModel> combinedAirports = [
                airport,
                ...nearbyAirports,
              ];

              final List<Marker> markers = combinedAirports.map((otherAirport) {
                final airportName = otherAirport.name;

                return Marker(
                  width: 150.0,
                  height: 150.0,
                  point: LatLng(
                    otherAirport.location.latitude - 0.0,
                    otherAirport.location.longitude + 0.0150,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InfoCardMAP(
                        title: airportName.length > 10
                            ? '${airportName.substring(0, 10)}...'
                            : airportName,
                        distance: '2.09 mi',
                        image: 'assets/images/Rectangle.png',
                      ),
                    ],
                  ),
                );
              }).toList();

              return Column(
                children: [
                  Expanded(
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(
                          airport.location.latitude,
                          airport.location.longitude,
                        ),
                        initialZoom: 13,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayer(markers: markers),
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 10, // Respect safe area
                          left: 16,
                          right: 16, // Ensure it doesn't overflow if title is long
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).cardColor.withOpacity(0.8),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 19,
                                  ),
                                  onPressed: () {
                                    if (Navigator.canPop(context)) Navigator.pop(context);
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded( // Allow title to take available space and potentially wrap or ellipsis
                                child: Text(
                                  'Show airport on map',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    // color: Theme.of(context).textTheme.bodyLarge?.color, // Inherits color
                                    // Adding a shadow or background for better visibility on map might be needed
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 10,
                          right: 10,
                           bottom: 10, // Consider MediaQuery.of(context).padding.bottom + 10 for safe area
                          child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 8.0), // Keep horizontal padding
                             // SizedBox with fixed width removed to allow carousel to be responsive
                             child: InfoDetailsCarouselMap(
                               airports: combinedAirports,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is AirportBlocError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('No Data'));
          },
        ),
      ),
    );
  }

  // دالة لحساب المسافة بين نقطتين باستخدام قانون هافيرسين
  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // نصف قطر الأرض بالكيلومترات
    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);
    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  // دالة لتحويل الدرجات إلى راديان
  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
