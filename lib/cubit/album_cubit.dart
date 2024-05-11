import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelista_flutter/pages/navpages/album_model.dart';

// State for AlbumCubit
class AlbumState extends Equatable {
  final List<Album> albums;

  AlbumState({required this.albums});

  @override
  List<Object> get props => [albums];
}

// Cubit for managing albums
class AlbumCubit extends Cubit<AlbumState> {
  AlbumCubit() : super(AlbumState(albums: [])); // Initialize with an empty list of albums

  // Create an album with a specific name and icon
  void createAlbum(String name, IconData icon) {
    final newAlbum = Album(name: name, icon: icon); // Updated album model
    emit(AlbumState(albums: [...state.albums, newAlbum])); // Emit updated state with the new album
  }

  // Rename an album at a given index
  void renameAlbum(int index, String newName) {
    final updatedAlbums = [...state.albums];
    updatedAlbums[index].rename(newName); // Rename the album
    emit(AlbumState(albums: updatedAlbums)); // Emit updated state after renaming
  }

  // Update the icon of an album at a given index
  void updateAlbumIcon(int index, IconData newIcon) {
    final updatedAlbums = [...state.albums];
    updatedAlbums[index].updateIcon(newIcon); // Update the album's icon
    emit(AlbumState(albums: updatedAlbums)); // Emit updated state after updating the icon
  }

  // Add a picture to an album at a given index
  void addPictureToAlbum(int index, String picturePath) {
    final updatedAlbums = [...state.albums];
    updatedAlbums[index].addPicture(picturePath); // Add the picture to the album
    print("Album updated with new picture."); // Debugging information

    emit(AlbumState(albums: updatedAlbums)); // Emit updated state after adding the picture
  }
}
