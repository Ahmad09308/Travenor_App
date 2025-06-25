// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travenor_app/core/config/favorite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteBloc({required this.favoriteRepository}) : super(FavoriteInitial()) {
    on<LoadFavoritesEvent>((event, emit) async {
      emit(FavoriteLoading());
      try {
        List<Map<String, dynamic>> favorites =
            await favoriteRepository.getFavorites();
        emit(FavoriteLoaded(favorites));
      } catch (e) {
        emit(FavoriteError('Failed to load favorites'));
      }
    });

    on<AddFavoriteEvent>((event, emit) async {
      if (state is FavoriteLoaded) {
        final currentFavorites = List<Map<String, dynamic>>.from(
            (state as FavoriteLoaded).favorites);

        // Check if newFavorite has an 'id' key and it's not null
        final newFavoriteId = event.newFavorite['id'];
        if (newFavoriteId == null) {
          // Optionally emit an error or handle cases where id is missing
          print("Warning: Attempted to add a favorite without an ID.");
          return;
        }

        final isAlreadySaved = currentFavorites.any((item) =>
            item['id'] == newFavoriteId);

        if (!isAlreadySaved) {
          currentFavorites.add(event.newFavorite);
          await favoriteRepository.saveFavorites(currentFavorites);
          emit(FavoriteLoaded(currentFavorites));
        } else {
          // Optionally, if it's already saved, maybe remove it (toggle behavior)
          // Or just do nothing / provide feedback it's already a favorite
          print("Item already in favorites.");
        }
      }
    });
    on<RemoveFavoriteEvent>((event, emit) async {
      if (state is FavoriteLoaded) {
        final currentFavorites = List<Map<String, dynamic>>.from(
            (state as FavoriteLoaded).favorites);

        final favoriteToRemoveId = event.favoriteToRemove['id'];
        if (favoriteToRemoveId == null) {
          print("Warning: Attempted to remove a favorite without an ID.");
          return;
        }

        currentFavorites.removeWhere((item) =>
            item['id'] == favoriteToRemoveId);

        await favoriteRepository.saveFavorites(currentFavorites);
        emit(FavoriteLoaded(currentFavorites));
      }
    });
  }
}
