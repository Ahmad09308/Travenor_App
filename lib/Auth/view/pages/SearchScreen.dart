// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor_app/Auth/view/pages/AirportDetailsPage.dart';
import 'package:travenor_app/core/bloc/bloc/airport_bloc_bloc.dart';
import 'package:travenor_app/core/model/AirportModel.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    final AirportBlocBloc airportBloc =
        BlocProvider.of<AirportBlocBloc>(context);

    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea( // Ensures content is within safe areas
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 25), // Replaced by SafeArea
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: theme.cardColor,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: theme.iconTheme.color,
                        size: 19,
                      ),
                      onPressed: () {
                        if (Navigator.canPop(context)) Navigator.pop(context);
                      },
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Search',
                      textAlign: TextAlign.center,
                      style: TextStyle( // This style was okay, but make color themeable
                        fontFamily: 'SF UI Display',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        // color: theme.textTheme.titleLarge?.color, // Use theme color
                      ), // Will inherit color from DefaultTextStyle or can be set explicitly
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Clear search or alternative cancel action
                      airportBloc.add(ClearSearchEvent());
                      // Potentially navigate back or clear text field
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: theme.primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  if (value.isEmpty) {
                    airportBloc.add(ClearSearchEvent());
                  } else {
                    airportBloc.add(SearchAirportsEvent(value));
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: theme.iconTheme.color?.withOpacity(0.7)),
                  suffixIcon: Icon(Icons.mic, color: theme.iconTheme.color?.withOpacity(0.7)),
                  hintText: 'Search Places',
                  hintStyle: theme.inputDecorationTheme.hintStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: theme.brightness == Brightness.light
                             ? Colors.grey[200]
                             : theme.inputDecorationTheme.fillColor ?? theme.colorScheme.surfaceVariant,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Search Results', // Changed from "Search Places"
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
            child: BlocBuilder<AirportBlocBloc, AirportBlocState>(
              builder: (context, state) {
                if (state is AirportBlocLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AirportBlocLoaded) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutBuilder( // Use LayoutBuilder for responsive crossAxisCount
                      builder: (context, constraints) {
                        int crossAxisCount = 2;
                        if (constraints.maxWidth > 900) { // Example breakpoint for large tablets
                          crossAxisCount = 4;
                        } else if (constraints.maxWidth > 600) { // Example breakpoint for tablets
                          crossAxisCount = 3;
                        }
                        double childAspectRatio = (constraints.maxWidth / crossAxisCount) / ( (constraints.maxWidth / crossAxisCount) / 0.75 ); // Maintain aspect ratio closer to 3/4

                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 16.0,
                            crossAxisSpacing: 16.0,
                            childAspectRatio: childAspectRatio, // Adjust as needed
                          ),
                          itemCount: state.airports.length,
                          itemBuilder: (context, index) {
                            return PlaceCard(airport: state.airports[index]);
                          }
                        );
                      }
                      },
                    ),
                  );
                } else if (state is AirportBlocError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const Center(child: Text('No results found.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  final AirportModel airport;

  const PlaceCard({super.key, required this.airport});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AirportDetailsPage(airport: airport),
          ),
        );
      },
      child: Card( // Using Card widget for better semantics and default elevation/shape
        margin: EdgeInsets.zero, // GridView already provides spacing
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4,
        shadowColor: theme.brightness == Brightness.dark ? Colors.black.withOpacity(0.7) : Colors.grey.withOpacity(0.3),
        color: theme.cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children horizontally
          children: [
            Expanded( // Image takes available vertical space in the Card's Column
              flex: 3, // Give more space to image
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: Image.asset(
                  'assets/images/destination.png', // Should be airport.imageUrl if available
                  // height: 100, // Removed fixed height
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 50, color: theme.iconTheme.color?.withOpacity(0.5)),
                ),
              ),
            ),
            Expanded( // Text content takes remaining space
              flex: 2, // Give less space to text compared to image
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribute space
                  children: [
                    Text(
                      airport.name,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 2, // Allow up to 2 lines for name
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: theme.iconTheme.color?.withOpacity(0.7)),
                        const SizedBox(width: 4),
                        Expanded( // Ensure city name doesn't overflow the row
                          child: Text(
                            airport.city,
                            style: theme.textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
