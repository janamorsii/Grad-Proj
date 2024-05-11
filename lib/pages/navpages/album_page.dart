import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelista_flutter/cubit/album_cubit.dart';
import 'package:travelista_flutter/pages/navpages/album_travel_icon.dart';
import 'album_detail_page.dart';

// Define a constant list of travel-related icons
const List<IconData> travelIcons = [
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

class AlbumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final albumCubit = BlocProvider.of<AlbumCubit>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Albums")), // Album title in AppBar
      body: BlocBuilder<AlbumCubit, AlbumState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.albums.length, // Number of albums
            itemBuilder: (context, index) {
              final album = state.albums[index];

              return ListTile(
                title: Text(album.name), // Album name
                leading: Icon(
                  album.albumIcon, // Use the IconData from the album
                ),
                onTap: () {
                  // Navigate to album details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AlbumDetailPage(index: index),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.edit), // Edit icon for renaming or changing album
                  onPressed: () {
                    final TextEditingController controller = TextEditingController();
                    controller.text = album.name; // Pre-fill with current album name

                    IconData selectedIcon = album.albumIcon; // Get the current album icon

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Edit Album"), // Title for the dialog
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // Compact column
                            children: [
                              TextField(
                                controller: controller, // Album name field
                                decoration: InputDecoration(labelText: "Album Name"), // Placeholder text
                              ),
                              SizedBox(height: 20), // Spacing
                              Text("Select Icon for Album"), // Icon selection label
                              SelectTravelIcon(
                                defaultIcon: selectedIcon, // Default icon
                                onIconSelected: (icon) {
                                  selectedIcon = icon; // Update the selected icon
                                },
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                albumCubit.renameAlbum(index, controller.text); // Rename the album
                                albumCubit.updateAlbumIcon(index, selectedIcon); // Update the album's icon
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text("Save"), // Button text
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final TextEditingController controller = TextEditingController(); // Controller for the new album name
          IconData defaultIcon = travelIcons.first; // Default starting icon

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Create Album"), // Dialog title
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Compact column
                  children: [
                    TextField(
                      controller: controller, // New album name input
                      decoration: InputDecoration(labelText: "Album Name"), // Placeholder text
                    ),
                    SizedBox(height: 20), // Spacing
                    Text("Select Icon for Album"), // Icon selection label
                    SelectTravelIcon(
                      defaultIcon: defaultIcon, // Default icon
                      onIconSelected: (icon) {
                        defaultIcon = icon; // Update the selected icon
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      albumCubit.createAlbum(controller.text, defaultIcon); // Create album with a default icon
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text("Create"), // Button text
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add), // Icon to add a new album
      ),
    );
  }
}
