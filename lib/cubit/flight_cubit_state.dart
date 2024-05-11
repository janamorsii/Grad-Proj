import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelista_flutter/model/flight_model.dart';

class FlightState extends Equatable {
  @override
  List<Object> get props => [];
}

class FlightInitial extends FlightState {}

class FlightLoading extends FlightState {}

class FlightSuccess extends FlightState {
  final List<Flight> flights;

  FlightSuccess(this.flights);

  @override
  List<Object> get props => [flights];
}

class FlightFailure extends FlightState {
  final String error;

  FlightFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Cubit to manage the flight search
class FlightCubit extends Cubit<FlightState> {
  final String baseUrl;
  final String apiKey;

  FlightCubit({required this.baseUrl, required this.apiKey}) : super(FlightInitial());

  Future<void> searchFlights(String depIata, String arrIata, String depDate) async {
    emit(FlightLoading());  // Start with loading state
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/schedules?dep_iata=$depIata&arr_iata=$arrIata&dep_date=$depDate&api_key=$apiKey'),  // Corrected endpoint
      );

      if (response.statusCode == 200) {  // Check for successful response
        final data = json.decode(response.body);
        if (data['response'] == null || !(data['response'] is List)) {  // Validate the data
          throw Exception("Invalid data format or no data returned");
        }

        final flights = (data['response'] as List).map((f) => Flight.fromJson(f)).toList();  // Safely parse the list
        emit(FlightSuccess(flights));  // Emit successful state
      } else {
        emit(FlightFailure("HTTP Error: ${response.statusCode}"));  // Handle non-200 status codes
      }
    } catch (e) {
      emit(FlightFailure("An error occurred: $e"));  // Catch all exceptions and emit failure state
    }
  }
}
