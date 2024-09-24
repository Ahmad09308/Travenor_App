// ignore_for_file: sized_box_for_whitespace, file_names

import 'package:flutter/material.dart';
import 'package:travenor_app/Auth/view/pages/view_page.dart';
import 'package:travenor_app/Auth/view/widget/button.dart';
import 'package:travenor_app/core/model/AirportModel.dart';

class AirportDetailsPage extends StatelessWidget {
  final AirportModel airport;

  const AirportDetailsPage({super.key, required this.airport});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/destination.png',
              fit: BoxFit.cover,
              height: 250,
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromRGBO(27, 30, 40, 0.384),
                  maxRadius: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color.fromRGBO(250, 250, 250, 1),
                      size: 19,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Text(
                  'Details',
                  style: TextStyle(
                    fontFamily: 'SF UI Display',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.bookmark_border,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      airport.name,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${airport.city}, ${airport.country}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          airport.city,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const Spacer(),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const Text(
                          '4.7',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        Text('(2498)',
                            style: TextStyle(color: Colors.grey[600])),
                        const Spacer(),
                        const Text(
                          '\$59/Person',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          buildImageThumbnail('assets/images/destination.png'),
                          buildImageThumbnail('assets/images/destination.png'),
                          buildImageThumbnail('assets/images/destination.png'),
                          buildImageThumbnail('assets/images/destination.png'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Airlines',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: airport.airlines
                          .map((airline) => Chip(
                                label: Text(airline),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Services',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: airport.services
                          .map((service) => Chip(
                                label: Text(service),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Terminals',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...airport.terminals.map((terminal) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            terminal.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ...terminal.gates.map((gate) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    gate.gateNumber,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Wrap(
                                    spacing: 4.0,
                                    children: gate.airlines
                                        .map((airline) => Chip(
                                              label: Text(airline),
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      );
                    }),
                    const SizedBox(height: 16),
                    const Text(
                      'Contact Information',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: Text(airport.contactInfo.phone),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: Text(airport.contactInfo.email),
                    ),
                    ListTile(
                      leading: const Icon(Icons.web),
                      title: Text(airport.contactInfo.website),
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'About Airport',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This airport is one of the busiest in the world and offers a wide range of services for travelers...',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Read More',
                          style: TextStyle(color: Colors.orange)),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: CustomButton(
                  text: 'Book Now',
                  onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewPage(selectedAirport: airport),
                      ),
                    );},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageThumbnail(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
