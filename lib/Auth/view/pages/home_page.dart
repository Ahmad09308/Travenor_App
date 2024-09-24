// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor_app/Auth/view/pages/SearchScreen.dart';
import 'package:travenor_app/Auth/view/widget/custom_bottom_navigation_bar.dart';
import 'package:travenor_app/Auth/view/widget/destination_card.dart';
import 'package:travenor_app/core/bloc/bloc/airport_bloc_bloc.dart';
import 'package:travenor_app/core/bloc/bloc/favorite_bloc.dart';
import 'package:travenor_app/core/config/favorite_repository.dart';
import 'package:travenor_app/core/services/AirportApi.dart';
import 'FavoritePlacesPage.dart';
import 'AirportDetailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePageContent(),
    const FavoritePlacesPage(),
    SearchPage(),
    const Center(child: Text('Messages Screen')),
    const Center(child: Text('Profile Screen')),
  ];

  void onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _screens[_selectedIndex],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavigationBar(
              onTabSelected: onTabSelected,
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AirportBlocBloc(airportService: AirportServiceImp())
                ..add(FetchAirportsEvent()),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(
            favoriteRepository: FavoriteRepository(),
          )..add(LoadFavoritesEvent()),
        ),
      ],
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 44,
                    width: 150,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(247, 247, 249, 1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user.png'),
                          radius: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Leonardo',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    minRadius: 20,
                    backgroundColor: const Color.fromRGBO(247, 247, 249, 1),
                    child: Badge(
                      backgroundColor: Colors.red,
                      alignment: Alignment(0.2, -0.3),
                      child: IconButton(
                        onPressed: () async {},
                        icon: const Icon(
                          Icons.notifications,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Explore the ',
                      style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                      children: [
                        TextSpan(
                            text: '\nBeautiful ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: 'world!',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 112, 41, 1),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Image.asset('assets/images/a2.png'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Best Destination',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('View all'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocListener<FavoriteBloc, FavoriteState>(
                  listener: (context, state) {
                    if (state is FavoriteLoaded) {
                      setState(() {});
                    }
                  },
                  child: BlocBuilder<AirportBlocBloc, AirportBlocState>(
                    builder: (context, state) {
                      if (state is AirportBlocLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is AirportBlocLoaded) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.airports.length,
                          itemBuilder: (context, index) {
                            final airport = state.airports[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AirportDetailsPage(airport: airport),
                                    ),
                                  );
                                },
                                child: DestinationCard(
                                  imageUrl: 'assets/images/destination.png',
                                  title: airport.name,
                                  location: airport.city,
                                  rating: 4.5,
                                  onSave: () {
                                    context.read<FavoriteBloc>().add(
                                          AddFavoriteEvent({
                                            'title': airport.name,
                                            'location': airport.city,
                                            'imageUrl':
                                                'assets/images/destination.png',
                                          }),
                                        );
                                  },
                                ),
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
              ),
              const SizedBox(
                height: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
