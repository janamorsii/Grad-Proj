import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'album_provider.dart';

class RenameAlbumPage extends StatefulWidget {
  final String albumId;

  RenameAlbumPage({required this.albumId});

  @override
  _RenameAlbumPageState createState() => _RenameAlbumPageState();
}

class _RenameAlbumPageState extends State<RenameAlbumPage> {
  late TextEditingController _albumNameController;

  @override
  void initState() {
    super.initState();
    final album = Provider.of<AlbumProvider>(context, listen: false)
        .albums
        .firstWhere((album) => album.id == widget.albumId);
    _albumNameController = TextEditingController(text: album.name); // Initialize with the current album name
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rename Album'), // AppBar title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _albumNameController,
              decoration: InputDecoration(
                labelText: 'New Album Name', // Input field for the new album name
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<AlbumProvider>(context, listen: false)
                    .renameAlbum(widget.albumId, _albumNameController.text);
                Navigator.pop(context); // Navigate back after renaming
              },
              child: Text('Rename Album'), // Button to rename the album
            ),
          ],
        ),
      ),
    );
  }
}
