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
    // final maxLength = MediaQuery.of(context).size.width ~/ 15; // Replaced by direct ellipsis
    final theme = Theme.of(context);

    return Container(
      // width: 300, // Width will be controlled by the parent ListView.builder itemExtent or SizedBox
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.brightness == Brightness.dark ? Colors.grey[800] : Colors.white, // Theme-aware background
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Important for ListView.builder with itemExtent
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title, // Removed truncateText
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 2, // Allow more lines for title
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 18), // Standard amber color for stars
                  const SizedBox(width: 4),
                  Text(
                    '$rating',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 16, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  location, // Removed truncateText
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // const Spacer(), // Removed Spacer, rely on Expanded
              const SizedBox(width: 8),
              Row( // Group participants together
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (String participant in participants.take(3)) // Show max 3 participants
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar( // Using CircleAvatar for images
                        backgroundImage: AssetImage(participant),
                        radius: 12,
                      ),
                    ),
                  if (participants.length > 3)
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.primaryColor.withOpacity(0.2),
                      ),
                      child: Center(
                        child: Text(
                          "+${participants.length - 3}",
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.timer_outlined, size: 16, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 8),
              Text(
                time,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
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
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 210, // Slightly increased height to accommodate padding/margins better
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: airports.length,
        itemBuilder: (context, index) {
          final airport = airports[index];
          return Container(
            width: screenWidth * 0.85, // Each card takes 85% of screen width
            margin: EdgeInsets.only(
              left: index == 0 ? 16.0 : 8.0, // Add left margin for the first item
              right: index == airports.length - 1 ? 16.0 : 8.0, // Add right margin for the last item
              top: 8.0, // Add some top/bottom margin for breathing room
              bottom: 8.0,
            ),
            child: InfoDetailsMap(
              title: airport.name,
              location: '${airport.city}, ${airport.country}',
              time: 'Estimated time', // This should be dynamic
              rating: 4.5, // This should be dynamic
              participants: const [ // This should be dynamic
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
    final theme = Theme.of(context);
    // Define a fixed width for the card, but allow height to adjust slightly if needed or keep it fixed.
    // For marker callouts, fixed sizes are often acceptable.
    const double cardWidth = 180; // Adjusted width slightly
    const double cardHeight = 60; // Adjusted height slightly

    return Column(
      mainAxisSize: MainAxisSize.min, // Important for marker layout
      crossAxisAlignment: CrossAxisAlignment.center, // Center the tail
      children: [
        Container(
          width: cardWidth,
          height: cardHeight,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), // Consistent rounding
            color: theme.brightness == Brightness.dark ? Colors.grey[800] : Colors.white,
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect( // Rounded corners for the image
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  image,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.place, size: 30, color: theme.iconTheme.color?.withOpacity(0.5)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded( // Allow text to take remaining space and handle overflow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, // Vertically center text
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      distance,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Triangle (or line and circle) to point to the marker location
        // This part can be tricky to make perfect without custom painters for a triangle.
        // A simple line and circle approach:
        Container(
          width: 2, // Width of the "tail" line
          height: 15, // Height of the "tail" line
          color: theme.brightness == Brightness.dark ? Colors.grey[800] : Colors.white, // Match card background
        ),
        Container( // The dot on the map
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.primaryColor, // Use primary color for the dot
            border: Border.all(color: theme.scaffoldBackgroundColor, width: 1.5) // Border to make it pop
          ),
        )
      ],
    );
  }
}
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
