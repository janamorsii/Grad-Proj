import 'package:flutter/material.dart';

class Album {
  String name;
  List<String> pictures;
  IconData icon; // Store the icon as IconData

  Album({
    required this.name,
    required this.icon, // Require an IconData when creating an album
    List<String>? pictures,
  }) : this.pictures = pictures ?? [];

  void addPicture(String picturePath) {
    pictures.add(picturePath);
  }

  void removePicture(int index) {
    if (index >= 0 && index < pictures.length) {
      pictures.removeAt(index);
    }
  }

  void rename(String newName) {
    name = newName;
  }

  void updateIcon(IconData newIcon) {
    icon = newIcon; // Update icon with IconData
  }

  // Method to get the album's icon
  IconData get albumIcon => icon;
}

// Constant list of album icons
const List<IconData> albumIcons = [
  Icons.airplanemode_active,
  Icons.work,
  Icons.beach_access,
  Icons.location_city,
  Icons.terrain,
  Icons.hotel,
  Icons.directions_car,
  Icons.directions_boat,
  Icons.place,
];
