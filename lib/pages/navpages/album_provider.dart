import 'package:flutter/material.dart';

class Album {
  final String id;
  String name;
  List<String> images;

  Album({required this.id, required this.name, required this.images});
}

class AlbumProvider with ChangeNotifier {
  List<Album> _albums = [];

  List<Album> get albums => _albums;

  void createAlbum(String name) {
    final newAlbum = Album(
      id: DateTime.now().toString(),
      name: name,
      images: [],
    );
    _albums.add(newAlbum);
    notifyListeners();
  }

  void renameAlbum(String albumId, String newName) {
    final album = _albums.firstWhere((album) => album.id == albumId);
    album.name = newName;
    notifyListeners();
  }

  Future<void> addImageToAlbum(String albumId, String imagePath) async {
    final album = _albums.firstWhere((album) => album.id == albumId);
    album.images.add(imagePath);
    notifyListeners();
  }
}
