import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteRepository {
  static const String _favoriteKey = 'savedItems';

  Future<void> saveFavorites(List<Map<String, dynamic>> favorites) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(favorites);
    await prefs.setString(_favoriteKey, encodedData);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString(_favoriteKey);
    if (savedData != null) {
      return List<Map<String, dynamic>>.from(json.decode(savedData));
    }
    return [];
  }
}
