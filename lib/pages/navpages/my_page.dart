import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:travelista_flutter/cubit/app_cubits.dart';
import 'package:travelista_flutter/pages/navpages/Booking_page.dart';
import 'package:travelista_flutter/services/Favorite_Provider.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

void _logout(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to log out? We'll miss you!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Do not log out
            },
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<AppCubits>(context).logout(); // Call logout function from Cubit
              Navigator.of(context).pop(true); // Close the dialog
            },
            child: Text("Yes"),
          ),
        ],
      );
    },
  );
}
  void _goToSettings(BuildContext context) {
    // Navigate to settings page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _goToSettings(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  // Placeholder for user image
                ),
                SizedBox(width: 16),
                Text(
                  "Hi, welcome to your page!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: Text("Logout"),
            ),
            SizedBox(height: 32),
            Text(
              "Favorites",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Consumer<FavoriteProvider>(
              builder: (context, favoriteProvider, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: favoriteProvider.favoriteHotels.length,
                  itemBuilder: (context, index) {
                    final String hotelName = favoriteProvider.favoriteHotels[index] ?? ""; // Ensure it's not null
                    return ListTile(
                      title: Text(hotelName),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 32),
            Text(
              "My Bookings",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Consumer<BookingProvider>(
              builder: (context, bookingProvider, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bookingProvider.bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookingProvider.bookings[index];
                    return ListTile(
                      title: Text("Hotel: ${booking.hotelName}"),
                      subtitle: Text("Date: ${booking.bookingDate} - Guests: ${booking.guests}"),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
