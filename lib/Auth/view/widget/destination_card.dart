// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

List participants = [
  'assets/images/0.png',
  'assets/images/1.png',
  'assets/images/2.png',
];

class DestinationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final double rating;
  final VoidCallback onSave;
  final bool isFavorite; // New parameter

  const DestinationCard({super.key, 
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.rating,
    required this.onSave,
    this.isFavorite = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.cardColor, // Use theme's card color
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.dark ? Colors.black.withOpacity(0.5) : Colors.black12, // Adjust shadow for dark theme
            blurRadius: 8,
            spreadRadius: 1, // Reduced spread for a possibly subtler look
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Image.asset(
                  imageUrl,
                  height: 225,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3), // Consistent scrim color
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.bookmark : Icons.bookmark_border, // Change icon based on state
                      color: isFavorite ? theme.primaryColor : Colors.white, // Change color based on state
                    ),
                    onPressed: onSave,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title.length > 20
                          ? '${title.substring(0, 18)}...'
                          : title,
                       style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                         color: theme.textTheme.bodyLarge?.color, // Use theme color
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                           color: Colors.orange, // Keep star color
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$rating',
                           style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                             color: theme.textTheme.bodyMedium?.color, // Use theme color
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      location,
                      style: TextStyle(fontSize: 14, color: theme.textTheme.bodySmall?.color ?? Colors.grey), // Use theme color
                    ),
                    const Spacer(),
                    for (String participant in participants)
                      Image.asset(participant, width: 24, height: 24),
                    Container(
                      width: 24,
                      height: 24,
                       decoration: BoxDecoration(
                        shape: BoxShape.circle,
                         color: theme.primaryColor.withOpacity(0.1), // Use a lighter shade of primary or a specific theme color
                      ),
                       child: Center(
                        child: Text(
                          "+50",
                          style: TextStyle(
                               fontSize: 8,
                               fontWeight: FontWeight.bold,
                               color: theme.primaryColor, // Text color related to primary
                           ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
