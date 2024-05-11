import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travelista_flutter/cubit/flight_cubit_state.dart';

class FlightsPage extends StatefulWidget {
  @override
  _FlightsPageState createState() => _FlightsPageState();
}

class _FlightsPageState extends State<FlightsPage> {
  final TextEditingController depAirportController = TextEditingController();
  final TextEditingController arrAirportController = TextEditingController();
  final TextEditingController depDateController = TextEditingController();
  final TextEditingController numPassengersController = TextEditingController();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  String tripType = 'One Way';  // Default trip type
  final List<String> tripTypes = ['One Way', 'Round Trip', 'Multi-City'];  // Available trip types

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Flights'),  // Page title
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),  // Consistent padding for layout
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Departure Airport Input
            TextField(
              controller: depAirportController,
              decoration: InputDecoration(labelText: 'Departure Airport'),
            ),

            // Arrival Airport Input
            TextField(
              controller: arrAirportController,
              decoration: InputDecoration(labelText: 'Arrival Airport'),
            ),

            // Departure Date Picker
            TextField(
              controller: depDateController,
              readOnly: true,
              decoration: InputDecoration(labelText: 'Departure Date'),
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2025),
                );
                if (pickedDate != null) {
                  depDateController.text = dateFormat.format(pickedDate);  // Set the selected date
                }
              },
            ),

            // Number of Passengers Input
            TextField(
              controller: numPassengersController,
              decoration: InputDecoration(labelText: 'Number of Passengers'),
              keyboardType: TextInputType.number,  // Input type for numbers
            ),

            // Trip Type Dropdown
            DropdownButton<String>(
              value: tripType,
              onChanged: (String? newValue) {
                setState(() {
                  tripType = newValue!;
                });
              },
              items: tripTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            SizedBox(height: 16),  // Space before the search button

            // Search Button
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<FlightCubit>(context).searchFlights(
                  depAirportController.text.trim(),
                  arrAirportController.text.trim(),
                  depDateController.text.trim(),
                    // Optional: Number of passengers
                );
              },
              child: Text("Search Flights"),  // Text for the button
            ),

            SizedBox(height: 16),  // Space before displaying results

            // Displaying Flight Results
            BlocBuilder<FlightCubit, FlightState>(
              builder: (context, state) {
                if (state is FlightLoading) {
                  return Center(child: CircularProgressIndicator());  // Loading indicator
                } else if (state is FlightSuccess) {
                  return Expanded(  // Expandable list of results
                    child: ListView.builder(
                      itemCount: state.flights.length,
                      itemBuilder: (context, index) {
                        final flight = state.flights[index];
                        return ListTile(
                          title: Text('${flight.airlineIata} ${flight.flightNumber}'),  // Flight details
                          subtitle: Text(
                            '${flight.depIata} (${flight.depTime}) to ${flight.arrIata} (${flight.arrTime})',
                          ),
                          onTap: () {
                            // Optional: Handle flight selection (e.g., navigate to flight details)
                          },
                        );
                      },
                    ),
                  );
                } else if (state is FlightFailure) {
                  return Center(child: Text("Error: ${state.error}"));  // Display error message
                } else {
                  return Center(child: Text("No flights found"));  // No results
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
