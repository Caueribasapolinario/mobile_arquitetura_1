import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesViewModel extends ChangeNotifier {
  List<int> _favoriteIds = [];

  List<int> get favoriteIds => _favoriteIds;

  FavoritesViewModel() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedFavorites = prefs.getStringList('favorites');
    if (savedFavorites != null) {
      _favoriteIds = savedFavorites.map(int.parse).toList();
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(int productId) async {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favoriteIds.map((e) => e.toString()).toList());
  }

  bool isFavorite(int productId) {
    return _favoriteIds.contains(productId);
  }
}