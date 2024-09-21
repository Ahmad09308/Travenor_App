import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor_app/Auth/view/widget/custom_bottom_navigation_bar.dart';
import 'package:travenor_app/Auth/view/widget/destination_card.dart';
import 'package:travenor_app/core/bloc/bloc/airport_bloc_bloc.dart';
import 'package:travenor_app/core/services/AirportApi.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AirportBlocBloc(airportService: AirportServiceImp())
        ..add(FetchAirportsEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        // CircleAvatar(
                        //   backgroundImage:
                        //       AssetImage('assets/user.jpg'),
                        //   radius: 25,
                        // ),
                        SizedBox(width: 10),
                        Text(
                          'Leonardo',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                RichText(
                  text: const TextSpan(
                    text: 'Explore the ',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: '\nBeautiful ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'world!',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 112, 41, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Best Destination',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('View all'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<AirportBlocBloc, AirportBlocState>(
                    builder: (context, state) {
                      if (state is AirportBlocLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is AirportBlocLoaded) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.airports.length,
                          itemBuilder: (context, index) {
                            final airport = state.airports[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DestinationCard(
                                imageUrl: 'assets/images/destination.png',
                                title: airport.name, 
                                location: airport.city, 
                                rating: 4.5,
                              ),
                            );
                          },
                        );
                      } else if (state is AirportBlocError) {
                        return Center(child: Text('Error: ${state.message}'));
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
