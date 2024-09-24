import 'package:flutter/material.dart';
import 'info_details.dart';
import 'package:travenor_app/core/model/AirportModel.dart';

class InfoDetailsCarousel extends StatelessWidget {
  final List<AirportModel> airports;

  const InfoDetailsCarousel({super.key, required this.airports});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: airports.length,
        itemBuilder: (context, index) {
          final airport = airports[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InfoDetails(
              title: airport.name,
              location: '${airport.city}, ${airport.country}',
              time: 'Estimated time',
              rating: 4.5, 
              participants: const [
                'assets/images/0.png',
                'assets/images/1.png',
                'assets/images/2.png',
              ],
              latitude: airport.location.latitude,
              longitude: airport.location.longitude,
            ),
          );
        },
      ),
    );
  }
}
