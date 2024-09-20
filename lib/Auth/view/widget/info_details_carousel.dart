import 'package:flutter/material.dart';
import 'info_details.dart';

class InfoDetailsCarousel extends StatelessWidget {
  const InfoDetailsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          InfoDetails(
            title: 'Niladri Reservoir',
            location: 'Tekergat, Sunamgnj',
            time: '45 Minutes',
            rating: 4.7,
            participants: [
              'assets/images/0.png',
              'assets/images/1.png',
              'assets/images/2.png',
            ],
          ),
          SizedBox(width: 16),
          InfoDetails(
            title: 'Lemon Garden',
            location: 'Sylhet, Bangladesh',
            time: '30 Minutes',
            rating: 4.5,
            participants: [
              'assets/images/0.png',
              'assets/images/1.png',
              'assets/images/2.png',
            ],
          ),
          SizedBox(width: 16), 
          InfoDetails(
            title: 'La-Hotel',
            location: 'Dhaka, Bangladesh',
            time: '25 Minutes',
            rating: 4.8,
            participants: [
              'assets/images/0.png',
              'assets/images/1.png',
              'assets/images/2.png',
            ],
          ),
        ],
      ),
    );
  }
}
