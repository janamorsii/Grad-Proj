import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Booking {
  final String hotelName;
  final String bookingDate;
  final String guests;

  Booking({
    required this.hotelName,
    required this.bookingDate,
    required this.guests,
  });
}

class BookingProvider extends ChangeNotifier {
  List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }
}

class BookingPage extends StatefulWidget {
  final String hotelName; // Add hotelName as a parameter
  const BookingPage({Key? key, required this.hotelName}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  int selectedGuests = 1;

  @override
  void dispose() {
    _dateController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book a Hotel"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hotel Booking for ${widget.hotelName}"), // Display hotel name
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: "Booking Date",
                border: OutlineInputBorder(),
              ),
              controller: _dateController,
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030, 12, 31),
                );
                if (selectedDate != null) {
                  _dateController.text = selectedDate.toLocal().toString().split(' ')[0];
                }
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: "Duration of Stay (in days)",
                border: OutlineInputBorder(),
              ),
              controller: _durationController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Text("Number of Guests"),
            DropdownButton<int>(
              value: selectedGuests,
              items: List.generate(5, (index) {
                return DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text((index + 1).toString()),
                );
              }),
              onChanged: (value) {
                setState(() {
                  selectedGuests = value!;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String date = _dateController.text;
                int duration = int.tryParse(_durationController.text) ?? 1;
                final booking = Booking(
                  hotelName: widget.hotelName, // Use the provided hotelName
                  bookingDate: date,
                  guests: selectedGuests.toString(),
                );
                Provider.of<BookingProvider>(context, listen: false).addBooking(booking);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Booking Confirmed - ${widget.hotelName}, $date, $duration days, $selectedGuests guests")),
                );
              },
              child: Text("Confirm Booking"),
            ),
          ],
        ),
      ),
    );
  }
}
