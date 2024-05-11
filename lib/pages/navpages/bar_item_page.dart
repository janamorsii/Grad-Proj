import 'dart:typed_data'; // For handling byte data
import 'dart:io'; // For file operations
import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // Camera functionalities
import 'package:permission_handler/permission_handler.dart'; // For permissions
import 'package:image/image.dart' as img; // Image manipulation
import 'package:travelista_flutter/cubit/album_cubit.dart'; // Bloc for album management

// Function to request camera and photo library permissions
Future<void> requestCameraAndPhotoPermissions(BuildContext context) async {
  final cameraStatus = await Permission.camera.request();
  final photoStatus = await Permission.photos.request(); // Request photo library permission

  if (cameraStatus.isDenied || cameraStatus.isPermanentlyDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Permission to access camera denied.")),
    );
    if (cameraStatus.isPermanentlyDenied) {
      await openAppSettings(); // Allow manual permission change
    }
  }

  if (photoStatus.isDenied || photoStatus.isPermanentlyDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Permission to access photos denied.")),
    );
    if (photoStatus.isPermanentlyDenied) {
      await openAppSettings(); // Allow manual permission change
    }
  }
}

class BarItemPage extends StatefulWidget {
  const BarItemPage({Key? key}) : super(key: key);

  @override
  _BarItemPageState createState() => _BarItemPageState();
}

class _BarItemPageState extends State<BarItemPage> {
  List<CameraDescription> _cameras = [];
  CameraController? _backCameraController;
  CameraController? _frontCameraController;

  @override
  void initState() {
    super.initState();
    initCameras(); // Initialize cameras
  }

  Future<void> initCameras() async {
    try {
      _cameras = await availableCameras(); // Get all cameras

      if (_cameras.isNotEmpty) {
        _backCameraController = CameraController(
          _cameras.first,
          ResolutionPreset.medium, // Use lower resolution for faster processing
        );
        _frontCameraController = CameraController(
          _cameras.last,
          ResolutionPreset.medium,
        );

        await _backCameraController?.initialize();
        await _frontCameraController?.initialize();

        setState(() {}); // Refresh UI after initialization
      } else {
        print("No cameras found.");
      }
    } catch (e) {
      print("Error initializing cameras: $e"); // Log error if initialization fails
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_backCameraController == null || !_backCameraController!.value.isInitialized ||
        _frontCameraController == null || !_frontCameraController!.value.isInitialized) {
      return Center(child: CircularProgressIndicator()); // Show loading while cameras initialize
    }

    return Scaffold(
      appBar: AppBar(title: Text("Bar Item Page")), // Navigation bar title
      body: Column(
        children: [
          Expanded(
            child: CameraPreview(_backCameraController!), // Show back camera preview
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await requestCameraAndPhotoPermissions(context); // Request camera and photo library permissions
                await Future.delayed(const Duration(seconds: 1)); // Give some time before taking photos

                final backPhoto = await _backCameraController!.takePicture();
                final frontPhoto = await _frontCameraController!.takePicture();

                if (backPhoto != null && frontPhoto != null) {
                  final combinedImage = await combineImages(backPhoto.path, frontPhoto.path);
                  // Perform an action with the combined image
                } else {
                  print("No photo captured.");
                }
              } catch (e) {
                print("Error capturing photo: $e"); // Handle exceptions
              }
            },
            child: Text("Take Photo"), // Button text
          ),
        ],
      ),
    );
  }

  // Function to combine two images with the front camera photo overlaid on the back camera photo
  Future<Uint8List> combineImages(String backPhotoPath, String frontPhotoPath) async {
    final backImage = img.decodeImage(await File(backPhotoPath).readAsBytes())!;
    final frontImage = img.decodeImage(await File(frontPhotoPath).readAsBytes())!;

    // Create a new image with the same dimensions as the back image
    final combinedImage = img.Image(backImage.width, backImage.height);

    // Draw the back image onto the new image
    img.drawImage(combinedImage, backImage);

    // Overlay the front image onto the back image in the top-left corner
    img.drawImage(combinedImage, frontImage, dstX: 10, dstY: 10);

    return Uint8List.fromList(img.encodeJpg(combinedImage)); // Return the combined image as a JPEG
  }

  @override
  void dispose() {
    _backCameraController?.dispose(); // Dispose of back camera
    _frontCameraController?.dispose(); // Dispose of front camera
    super.dispose(); // Clean up resources
  }
}
