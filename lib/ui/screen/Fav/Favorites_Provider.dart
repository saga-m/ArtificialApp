import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  void addToFavorites(Map<String, dynamic> worker) {
    if (!_favorites.any((element) => element['name'] == worker['name'])) {
      _favorites.add(worker);
      notifyListeners();
    }
  }

  void removeFromFavorites(String name) {
    _favorites.removeWhere((worker) => worker['name'] == name);
    notifyListeners();
  }
}
