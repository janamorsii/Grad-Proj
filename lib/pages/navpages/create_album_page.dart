import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'album_provider.dart'; // Importing AlbumProvider

class CreateAlbumPage extends StatefulWidget {
  @override
  _CreateAlbumPageState createState() => _CreateAlbumPageState();
}

class _CreateAlbumPageState extends State<CreateAlbumPage> {
  final _albumNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Album')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _albumNameController,
              decoration: InputDecoration(
                labelText: 'Album Name', // Input field for album name
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<AlbumProvider>(context, listen: false)
                    .createAlbum(_albumNameController.text);
                Navigator.pop(context); // Go back after creating an album
              },
              child: Text('Create Album'), // Button to create an album
            ),
          ],
        ),
      ),
    );
  }
}
