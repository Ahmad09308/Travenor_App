// ignore_for_file: sized_box_for_whitespace, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc
import 'package:travenor_app/Auth/view/pages/view_page.dart';
import 'package:travenor_app/Auth/view/widget/button.dart';
import 'package:travenor_app/core/model/AirportModel.dart';
import 'package:travenor_app/core/bloc/bloc/favorite_bloc.dart'; // Import FavoriteBloc

class AirportDetailsPage extends StatelessWidget {
  final AirportModel airport;

  const AirportDetailsPage({super.key, required this.airport});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final double screenHeight = mediaQuery.size.height;
    final double screenWidth = mediaQuery.size.width;

    final double imageHeight = screenHeight * 0.35; // Image takes 35% of screen height
    final double contentTopPosition = imageHeight - 50; // Overlap image slightly

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/destination.png', // Replace with airport.imageUrl if available
              fit: BoxFit.cover,
              height: imageHeight,
              width: screenWidth,
            ),
          ),
          Positioned(
            top: mediaQuery.padding.top + 10, // Respect safe area + padding
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.4), // Consistent scrim
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 19,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Text(
                  'Details',
                  style: TextStyle(
                    fontFamily: 'SF UI Display', // Consider using theme.textTheme
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 2, color: Colors.black.withOpacity(0.5))], // Text shadow for readability
                  ),
                ),
                CircleAvatar(
                  child: BlocBuilder<FavoriteBloc, FavoriteState>( // Listen to FavoriteBloc
                    builder: (context, favoriteState) {
                      bool isFavorite = false;
                      if (favoriteState is FavoriteLoaded) {
                        isFavorite = favoriteState.favorites.any((fav) => fav['id'] == airport.id);
                      }
                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.bookmark : Icons.bookmark_border,
                          color: isFavorite ? theme.primaryColor : Colors.white,
                        ),
                        onPressed: () {
                          final favoriteMap = {
                            'id': airport.id,
                            'title': airport.name,
                            'location': airport.city,
                            'country': airport.country,
                            'code': airport.code,
                            'imageUrl': 'assets/images/destination.png', // Placeholder, ideally from airport model or a default
                          };
                          if (isFavorite) {
                            context.read<FavoriteBloc>().add(RemoveFavoriteEvent(favoriteMap));
                          } else {
                            context.read<FavoriteBloc>().add(AddFavoriteEvent(favoriteMap));
                          }
                        },
                      );
                    },
                  )
                ),
              ],
            ),
          ),
          Positioned(
            top: contentTopPosition,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24), // Adjusted padding
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor, // Use theme color
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), // Slightly reduced radius
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(builder: (context, constraints) {
                      double nameFontSize = constraints.maxWidth < 360 ? 20 : 24;
                      return Text(
                        airport.name,
                        softWrap: true,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: nameFontSize,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      );
                    }),
                    const SizedBox(height: 4),
                    Text(
                      '${airport.city}, ${airport.country}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: 12), // Increased spacing
                    Row(
                      children: [
                        Icon(Icons.location_on, color: theme.iconTheme.color?.withOpacity(0.7), size: 18),
                        const SizedBox(width: 4),
                        Expanded( // Allow city to take space but not overflow
                          child: Text(
                            airport.city,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodySmall?.color),
                          ),
                        ),
                        // const Spacer(), // Use Expanded instead of Spacer for better control
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.star,
                          color: Colors.amber, // Keep specific color for rating star
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '4.7', // This should be dynamic
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '(2498)', // This should be dynamic
                           style: theme.textTheme.bodySmall?.copyWith(color: theme.textTheme.bodySmall?.color),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '\$59/Person', // This should be dynamic
                          style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20), // Increased spacing
                    Container(
                      height: 80, // Adjusted to fit images properly
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [ // Assuming airport.imageUrls is a list of strings
                          // airport.imageUrls.map((url) => buildImageThumbnail(url)).toList()
                          // For now, using placeholders:
                          buildImageThumbnail('assets/images/destination.png', theme),
                          buildImageThumbnail('assets/images/destination.png', theme),
                          buildImageThumbnail('assets/images/destination.png', theme),
                          buildImageThumbnail('assets/images/destination.png', theme),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Airlines',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: airport.airlines
                          .map((airline) => Chip(
                                label: Text(airline),
                                backgroundColor: theme.chipTheme.backgroundColor,
                                labelStyle: theme.chipTheme.labelStyle,
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Services',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: airport.services
                          .map((service) => Chip(
                                label: Text(service),
                                backgroundColor: theme.chipTheme.backgroundColor,
                                labelStyle: theme.chipTheme.labelStyle,
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Terminals',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...airport.terminals.map((terminal) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              terminal.name,
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            ...terminal.gates.map((gate) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      gate.gateNumber,
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.textTheme.bodySmall?.color,
                                      ),
                                    ),
                                    if (gate.airlines.isNotEmpty) ...[
                                      const SizedBox(height: 4),
                                      Wrap(
                                        spacing: 4.0,
                                        runSpacing: 4.0,
                                        children: gate.airlines
                                            .map((airline) => Chip(
                                                  label: Text(airline, style: TextStyle(fontSize: 10)), // Smaller text for nested chips
                                                  backgroundColor: theme.chipTheme.secondarySelectedColor, // Different color for distinction
                                                  labelStyle: theme.chipTheme.secondaryLabelStyle?.copyWith(fontSize: 10),
                                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                ))
                                            .toList(),
                                      ),
                                    ]
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    Text(
                      'Contact Information',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: Icon(Icons.phone, color: theme.iconTheme.color),
                      title: Text(airport.contactInfo.phone, style: theme.textTheme.bodyLarge),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      leading: Icon(Icons.email, color: theme.iconTheme.color),
                      title: Text(airport.contactInfo.email, style: theme.textTheme.bodyLarge),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      leading: Icon(Icons.web, color: theme.iconTheme.color),
                      title: Text(airport.contactInfo.website, style: theme.textTheme.bodyLarge?.copyWith(color: theme.primaryColor)),
                      onTap: () { /* TODO: Implement launch URL */ },
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'About Airport',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This airport is one of the busiest in the world and offers a wide range of services for travelers...', // This should be from airport.description or similar
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodySmall?.color),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () { /* TODO: Implement show full description */ },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.centerLeft),
                      child: Text('Read More', style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: mediaQuery.padding.bottom + 70), // Space for floating button and system navigation
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
              color: theme.scaffoldBackgroundColor.withOpacity(0.95), // Slightly transparent to show content behind if any
              padding: EdgeInsets.only(left: 20, right: 20, bottom: mediaQuery.padding.bottom + 10, top: 10), // Respect safe area
              child: CustomButton( // Assuming CustomButton is theme-aware
                text: 'Book Now',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewPage(selectedAirport: airport), // ViewPage needs to be reviewed for responsiveness
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageThumbnail(String imagePath, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // Slightly larger radius
        child: Image.asset( // In a real app, this might be Image.network if URLs are provided
          imagePath,
          width: 80, // Keep width
          height: 80, // Match container height
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) { // Placeholder for error
            return Container(
              width: 80,
              height: 80,
              color: theme.colorScheme.surfaceVariant,
              child: Icon(Icons.broken_image, color: theme.iconTheme.color?.withOpacity(0.5)),
            );
          },
        ),
      ),
    );
  }
}
