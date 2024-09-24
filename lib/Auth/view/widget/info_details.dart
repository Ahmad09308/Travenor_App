import 'package:flutter/material.dart';
import 'package:travenor_app/Auth/view/widget/button.dart';

class InfoDetails extends StatelessWidget {
  final String title;
  final String location;
  final String time;
  final double rating;
  final List<String> participants;
  final double latitude;
  final double longitude;

  const InfoDetails({
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
    final maxLength = MediaQuery.of(context).size.width ~/
        15; // Adjust this value to fit design

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
                  truncateText(
                      title, maxLength), 
                  style: const TextStyle(
                    fontFamily: 'SF UI Display',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                    overflow:
                        TextOverflow.ellipsis, 
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
                  truncateText(location,
                      maxLength), 
                  style: const TextStyle(
                    fontFamily: 'SF UI Display',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Colors.white,
                    overflow:
                        TextOverflow.ellipsis, 
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
            text: 'See On The Map',
            onPressed: () {
              // ignore: avoid_print
              print('Latitude: $latitude, Longitude: $longitude');
            },
          ),
        ],
      ),
    );
  }
}
