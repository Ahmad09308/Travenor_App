// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor_app/core/bloc/bloc/favorite_bloc.dart';

class FavoritePlacesPage extends StatefulWidget {
  const FavoritePlacesPage({super.key});

  @override
  State<FavoritePlacesPage> createState() => _FavoritePlacesPageState();
}

class _FavoritePlacesPageState extends State<FavoritePlacesPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea( // Add SafeArea
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
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
                  Expanded(
                    child: Text(
                      'Favorite Places',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 40) // Placeholder to balance the CircleAvatar space if needed, or remove if title centering is enough
                ],
              ),
              const SizedBox(height: 24), // Increased spacing
              // Header Text
              Text(
                'Your Favorites', // Slightly different title
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (context, state) {
                    if (state is FavoriteLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FavoriteLoaded) {
                      if (state.favorites.isEmpty) {
                        return Center(
                            child: Text(
                          'No favorite places added yet.',
                          style: theme.textTheme.bodyLarge,
                        ));
                      }

                      return LayoutBuilder( // For responsive crossAxisCount
                        builder: (context, constraints) {
                          int crossAxisCount = 2;
                          if (constraints.maxWidth > 900) {
                            crossAxisCount = 4;
                          } else if (constraints.maxWidth > 600) {
                            crossAxisCount = 3;
                          }
                           // Adjust aspect ratio to maintain card shape, e.g. aiming for ~150-200 width, ~200-250 height
                          double cardWidth = (constraints.maxWidth - (crossAxisCount -1) * 10) / crossAxisCount;
                          double cardHeight = cardWidth / 0.72; // Maintain original aspect ratio based on new width


                          return GridView.builder(
                            itemCount: state.favorites.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10, // Increased crossAxisSpacing
                              childAspectRatio: cardWidth / cardHeight,
                            ),
                            itemBuilder: (context, index) {
                              final item = state.favorites[index];
                              return buildPlaceCard(context, item, theme);
                            }
                          );
                        }
                      },
                    );
                  } else if (state is FavoriteError) {
                    return Center(child: Text(state.message));
                  }

                  return const Center(child: Text('No favorite places added.'));
                },
              ),
            ),
            const SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlaceCard(BuildContext context, Map<String, dynamic> item, ThemeData theme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3, // Adjusted elevation
      shadowColor: theme.shadowColor.withOpacity(0.3),
      color: theme.cardColor,
      child: Column( // No ClipRRect needed here if Card has shape and children are clipped or rounded appropriately
        crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children
        children: [
          Expanded( // Image takes up a portion of the card
            flex: 3, // Adjust flex factor as needed for image height
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect( // Clip the image to rounded corners
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.asset(
                      item['imageUrl'] ?? 'assets/images/destination.png', // Fallback image
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.broken_image, color: theme.iconTheme.color?.withOpacity(0.5), size: 40)),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar( // Give icon a background for better visibility
                    backgroundColor: theme.cardColor.withOpacity(0.7),
                    radius: 18,
                    child: IconButton(
                      icon: Icon(Icons.favorite, color: theme.primaryColor), // Use primary color for liked
                      iconSize: 20,
                      onPressed: () {
                        // Ensure 'item' contains the 'id' field
                        if (item['id'] == null) {
                           print("Error: Favorite item missing ID, cannot remove.");
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Error removing favorite: Missing ID."))
                           );
                           return;
                        }
                        context
                            .read<FavoriteBloc>()
                            .add(RemoveFavoriteEvent(item)); // 'item' already contains the 'id'
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded( // Text content takes remaining space
            flex: 2, // Adjust flex factor
            child: Padding(
              padding: const EdgeInsets.all(10.0), // Slightly increased padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Better distribute space
                children: [
                  Text(
                    item['title'] ?? 'No Title',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2, // Allow title to wrap to 2 lines
                    overflow: TextOverflow.ellipsis,
                  ),
                  // const SizedBox(height: 4), // Removed fixed SizedBox, relying on spaceAround
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: theme.iconTheme.color?.withOpacity(0.7)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item['location'] ?? 'No Location',
                          style: theme.textTheme.bodySmall,
                          maxLines: 1, // Location on single line
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
    );
  }
}
