import 'package:flutter/material.dart';
import 'package:travelista_flutter/model/flight_model.dart';

class FlightDetailsPage extends StatelessWidget {
  final Flight flight;

  FlightDetailsPage(this.flight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flight Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Flight: ${flight.flightIata}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text('Airline: ${flight.airlineIata}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Departure Airport: ${flight.depIata}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Arrival Airport: ${flight.arrIata}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Departure Time: ${flight.depTime}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Arrival Time: ${flight.arrTime}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Duration: ${flight.duration} minutes', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
