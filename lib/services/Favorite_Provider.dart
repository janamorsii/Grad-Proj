import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteHotels = [];

  List<String> get favoriteHotels => _favoriteHotels;

  void addFavorite(String hotelName) {
    if (!_favoriteHotels.contains(hotelName)) {
      _favoriteHotels.add(hotelName);
      notifyListeners();
    }
  }

  void removeFavorite(String hotelName) {
    _favoriteHotels.remove(hotelName);
    notifyListeners();
  }
}
