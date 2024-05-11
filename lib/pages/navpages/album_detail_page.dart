import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart'; // For permissions
import 'package:image_picker/image_picker.dart'; // For picking images
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelista_flutter/cubit/album_cubit.dart';
import 'dart:io'; // For file operations

// Function to request photo library permission
Future<void> requestPhotoLibraryPermission(BuildContext context) async {
  final status = await Permission.photos.request(); // Request permission for photo access

  if (status.isDenied || status.isPermanentlyDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Permission to access photos denied.")), // Inform the user if denied
    );
    if (status.isPermanentlyDenied) {
      await openAppSettings(); // Open app settings to allow manual permission change
    }
  }
}

class AlbumDetailPage extends StatelessWidget {
  final int index;

  AlbumDetailPage({required this.index});

  @override
  Widget build(BuildContext context) {
    final albumCubit = BlocProvider.of<AlbumCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AlbumCubit, AlbumState>(
          builder: (context, state) {
            final album = state.albums[index];
            return Text(album.name); // Display the album's name
          },
        ),
      ),
      body: BlocBuilder<AlbumCubit, AlbumState>(
        builder: (context, state) {
          final album = state.albums[index]; // Get the current album from the state

          if (album.pictures.isEmpty) {
            return Center(
              child: Text(
                "No pictures in this album, let's add some!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            );
          }

          // Use PageView to scroll through photos
          return PageView.builder(
            itemCount: album.pictures.length,
            itemBuilder: (context, picIndex) {
              final imagePath = album.pictures[picIndex]; // Path of the photo
              return Image.file(
                File(imagePath), // Load the photo from a local file
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Handle errors if the image can't be loaded
                  return Center(
                    child: Text("Error loading image."),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await requestPhotoLibraryPermission(context); // Request permission before accessing photos

          final picker = ImagePicker(); // Create an image picker instance
          final XFile? image = await picker.pickImage(source: ImageSource.gallery); // Pick an image from the gallery

          if (image != null) {
            albumCubit.addPictureToAlbum(index, image.path); // Add the photo to the album
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("No image selected.")), // Inform the user if no image was picked
            );
          }
        },
        child: Icon(Icons.add_a_photo), // Icon for adding a photo
      ),
    );
  }
}
