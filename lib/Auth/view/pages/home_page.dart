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
import 'package:travenor_app/core/services/notification_service.dart'; // Import NotificationService
import 'package:travenor_app/core/theme/theme_cubit.dart'; // Import ThemeCubit
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
      // backgroundColor: Colors.white, // Removed to use theme's scaffoldBackgroundColor
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
                  Expanded(
                    child: Container(
                      height: 44,
                      // width: 150, // Removed fixed width for flexibility
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor, // Use theme color
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/images/user.png'),
                            radius: 20, // Slightly smaller to fit
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Leonardo', // This should ideally come from user data
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return Switch(
                        value: state.isDarkMode,
                        onChanged: (value) {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  IconButton( // Button to trigger mock reminder
                    icon: Icon(Icons.notification_add, color: Theme.of(context).iconTheme.color),
                    onPressed: () {
                      NotificationService().showMockReminderNotification();
                    },
                    tooltip: 'Show Mock Reminder',
                  ),
                  // const SizedBox(width: 8), // Original notification icon can be kept or removed
                  CircleAvatar(
                    minRadius: 20,
                    backgroundColor: Theme.of(context).cardColor, // Use theme color
                    child: Badge(
                      backgroundColor: Colors.red,
                      alignment: const Alignment(0.2, -0.3),
                      child: IconButton(
                        onPressed: () async {
                          // Original Notification action
                        },
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
                  LayoutBuilder( // Use LayoutBuilder to make font size responsive
                    builder: (context, constraints) {
                      double baseFontSize = constraints.maxWidth < 360 ? 30 : 38; // Smaller font for very small screens
                      return RichText(
                        text: TextSpan(
                          text: 'Explore the ',
                          style: TextStyle(
                            fontSize: baseFontSize,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).textTheme.bodyLarge?.color, // Use theme color
                          ),
                          children: [
                            TextSpan(
                              text: '\nBeautiful ',
                              style: TextStyle(
                                fontSize: baseFontSize, // Ensure consistent size
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).textTheme.bodyLarge?.color, // Use theme color
                              ),
                            ),
                            TextSpan(
                              text: 'world!',
                              style: TextStyle(
                                  fontSize: baseFontSize, // Ensure consistent size
                                  color: const Color.fromRGBO(255, 112, 41, 1), // Primary accent color, can remain
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                  Align( // Align the image to the right
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0, top: 8.0), // Adjusted padding
                      child: FractionallySizedBox(
                        widthFactor: 0.3, // Image takes up to 30% of the available width
                        child: Image.asset(
                          'assets/images/a2.png',
                          fit: BoxFit.contain, // Ensures the image scales correctly
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best Destination',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color, // Use theme color
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View all',
                      style: TextStyle(color: Theme.of(context).primaryColor), // Use theme color
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<AirportBlocBloc, AirportBlocState>( // Outer BlocBuilder for airports
                  builder: (context, airportState) {
                    if (airportState is AirportBlocLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (airportState is AirportBlocLoaded) {
                      return BlocBuilder<FavoriteBloc, FavoriteState>( // Inner BlocBuilder for favorites
                        builder: (context, favoriteState) {
                          List<Map<String, dynamic>> currentFavorites = [];
                          if (favoriteState is FavoriteLoaded) {
                            currentFavorites = favoriteState.favorites;
                          }

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: airportState.airports.length,
                            itemBuilder: (context, index) {
                              final airport = airportState.airports[index];
                              final isFavorite = currentFavorites.any((fav) => fav['id'] == airport.id);

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
                                    imageUrl: 'assets/images/destination.png', // Placeholder
                                    title: airport.name,
                                    location: airport.city,
                                    rating: 4.5, // This should be dynamic if available
                                    isFavorite: isFavorite, // Pass the status
                                    onSave: () {
                                      if (isFavorite) {
                                        // If already favorite, dispatch remove event
                                        // Need to construct the map as expected by RemoveFavoriteEvent
                                        context.read<FavoriteBloc>().add(RemoveFavoriteEvent({'id': airport.id, 'title': airport.name, 'location': airport.city, 'imageUrl': 'assets/images/destination.png'}));
                                      } else {
                                        // If not favorite, dispatch add event
                                        context.read<FavoriteBloc>().add(
                                              AddFavoriteEvent({
                                                'id': airport.id,
                                                'title': airport.name,
                                                'location': airport.city,
                                                'country': airport.country,
                                                'code': airport.code,
                                                'imageUrl': 'assets/images/destination.png',
                                              }),
                                            );
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else if (airportState is AirportBlocError) {
                      return Center(child: Text('Error: ${airportState.message}'));
                    }
                    return const Center(child: Text("Loading airports...")); // Default for AirportBlocInitial etc.
                  },
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
