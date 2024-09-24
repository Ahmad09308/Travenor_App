import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor_app/Auth/view/widget/info_card.dart';
import 'package:travenor_app/Auth/view/widget/info_details_carousel.dart';
import 'package:travenor_app/core/bloc/bloc/airport_bloc_bloc.dart';
import 'package:travenor_app/core/model/AirportModel.dart';

class ViewPage extends StatelessWidget {
  final AirportModel selectedAirport;

  const ViewPage({super.key, required this.selectedAirport});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background_image.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: Row(
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
                  const SizedBox(width: 100),
                  const Text(
                    'View',
                    style: TextStyle(
                      fontFamily: 'SF UI Display',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              top: 300,
              left: 23,
              child: InfoCard(
                title: 'Lemon Garden',
                distance: '2.09 mi',
                image: 'assets/images/Rectangle.png',
              ),
            ),
            const Positioned(
              top: 144,
              left: 167,
              child: InfoCard(
                title: 'La-Hotel',
                distance: '2.09 mi',
                image: 'assets/images/Rectangle.png',
              ),
            ),
            Positioned(
              bottom: 20,
              left: 5,
              right: 5,
              child: BlocBuilder<AirportBlocBloc, AirportBlocState>(
                builder: (context, state) {
                  if (state is AirportBlocLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AirportBlocLoaded) {
                    final List<AirportModel> airports = state.airports;

                    final List<AirportModel> combinedAirports = [
                      selectedAirport,
                      ...airports
                          .where((airport) => airport.id != selectedAirport.id),
                    ];

                    return InfoDetailsCarousel(
                      airports: combinedAirports,
                    );
                  } else if (state is AirportBlocError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }

                  return const Center(child: Text('No Data'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
