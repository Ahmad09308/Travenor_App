// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:travenor_app/Auth/view/widget/button.dart';
import 'package:travenor_app/core/model/AirportModel.dart';

class InfoDetailsMap extends StatelessWidget {
  final String title;
  final String location;
  final String time;
  final double rating;
  final List<String> participants;
  final double latitude;
  final double longitude;

  const InfoDetailsMap({
    super.key,
    required this.title,
    required this.location,
    required this.time,
    required this.rating,
    required this.participants,
    required this.latitude,
    required this.longitude,
  });

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    final maxLength = MediaQuery.of(context).size.width ~/ 15;

    return Container(
      width: 300,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(62, 62, 62, 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  truncateText(title, maxLength),
                  style: const TextStyle(
                    fontFamily: 'SF UI Display',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star,
                      color: Color.fromRGBO(255, 211, 54, 1), size: 16),
                  Text(
                    '$rating',
                    style: const TextStyle(
                      fontFamily: 'SF UI Display',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 16, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  truncateText(location, maxLength),
                  style: const TextStyle(
                    fontFamily: 'SF UI Display',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
              const Spacer(),
              for (String participant in participants)
                Image.asset(participant, width: 24, height: 24),
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(229, 244, 255, 1),
                ),
                child: const Center(
                  child: Text(
                    "+50",
                    style: TextStyle(
                      fontFamily: 'SF UI Display',
                      fontSize: 11,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.timer_outlined, size: 16, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                time,
                style: const TextStyle(
                  fontFamily: 'SF UI Display',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Airport reservation',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class InfoDetailsCarouselMap extends StatelessWidget {
  final List<AirportModel> airports;

  const InfoDetailsCarouselMap({super.key, required this.airports});

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
            child: InfoDetailsMap(
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


class InfoCardMAP extends StatelessWidget {
  final String title;
  final String distance;
  final String image;

  const InfoCardMAP({
    super.key,
    required this.title,
    required this.distance,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 186,
              height: 62,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromRGBO(62, 62, 62, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: Row(
                children: [
                  Image.asset(image, width: 42, height: 42),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'SF UI Display',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        distance,
                        style: const TextStyle(
                          fontFamily: 'SF UI Display',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          width: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 2,
                height: 50,
                color: const Color.fromRGBO(62, 62, 62, 1),
              ),
              CircleAvatar(
                backgroundColor: const Color.fromRGBO(62, 62, 62, 1),
                maxRadius: 15,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
