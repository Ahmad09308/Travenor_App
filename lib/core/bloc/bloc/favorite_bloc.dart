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

        final isAlreadySaved = currentFavorites.any((item) =>
            item['title'] == event.newFavorite['title'] &&
            item['location'] == event.newFavorite['location']);

        if (!isAlreadySaved) {
          currentFavorites.add(event.newFavorite);
          await favoriteRepository.saveFavorites(currentFavorites);
          emit(FavoriteLoaded(currentFavorites));
        }
      }
    });
    on<RemoveFavoriteEvent>((event, emit) async {
      if (state is FavoriteLoaded) {
        final currentFavorites = List<Map<String, dynamic>>.from(
            (state as FavoriteLoaded).favorites);

        currentFavorites.removeWhere((item) =>
            item['title'] == event.favoriteToRemove['title'] &&
            item['location'] == event.favoriteToRemove['location']);

        await favoriteRepository.saveFavorites(currentFavorites);
        emit(FavoriteLoaded(currentFavorites));
      }
    });
  }
}
