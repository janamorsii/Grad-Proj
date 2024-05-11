import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class BookingModel extends ChangeNotifier {
  List<Map<String, String>> _bookings = [];

  List<Map<String, String>> get bookings => _bookings;

  void addBooking(Map<String, String> bookingDetails) {
    _bookings.add(bookingDetails);
    notifyListeners(); // Notify listeners about the change
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BookingModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Your MaterialApp code...
    );
  }
}
