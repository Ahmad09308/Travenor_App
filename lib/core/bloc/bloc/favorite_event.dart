part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}


class LoadFavoritesEvent extends FavoriteEvent {}
class AddFavoriteEvent extends FavoriteEvent {
  final Map<String, dynamic> newFavorite;
  AddFavoriteEvent(this.newFavorite);
}

class RemoveFavoriteEvent extends FavoriteEvent {
  final Map<String, dynamic> favoriteToRemove;
  RemoveFavoriteEvent(this.favoriteToRemove);
}
