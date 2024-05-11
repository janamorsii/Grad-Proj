// import 'package:http/http.dart' as http;
// import 'package:travelista_flutter/model/flight_model.dart';
// import 'dart:convert'; // For decoding JSON

// class FlightService {
//   final String baseUrl; // Base URL for the API
//   final String apiKey; // API key for authentication

//   FlightService({required this.baseUrl, required this.apiKey});

//   // Fetch flights from the API
//   Future<List<FlightModel>> fetchFlights() async {
//     final response = await http.get(Uri.parse('$baseUrl/flights?api_key=$apiKey'));

//     if (response.statusCode == 200) {
//       // If the API call is successful, decode the JSON and convert it to a list of `FlightModel`
//       final data = json.decode(response.body);
//       final List<FlightModel> flights = (data['flights'] as List)
//           .map((item) => FlightModel.fromJson(item))
//           .toList();
//       return flights;
//     } else {
//       // If the call fails, throw an exception with the status code
//       throw Exception("Failed to fetch flights: ${response.statusCode}");
//     }
//   }
// }
