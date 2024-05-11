import 'package:equatable/equatable.dart';

// Flight information model
class Flight extends Equatable {
  final String airlineIata;
  final String flightIata;
  final String flightNumber;  // Using the correct parameter name
  final String depIata;
  final String arrIata;
  final String depTime;
  final String arrTime;
  final double duration;  // Ensure the correct type

  Flight({
    required this.airlineIata,
    required this.flightIata,
    required this.flightNumber,  // Using the correct parameter name
    required this.depIata,
    required this.arrIata,
    required this.depTime,
    required this.arrTime,
    required this.duration,
  });

  @override
  List<Object> get props => [airlineIata, flightIata, flightNumber, depIata, arrIata, depTime, arrTime, duration];  // Ensure all unique fields are in props

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      airlineIata: json['airline_iata'] ?? '',  // Use default value if null
      flightIata: json['flight_iata'] ?? '',
      flightNumber: json['flight_number'] ?? '',  // Use the correct parameter and default value
      depIata: json['dep_iata'] ?? '',
      arrIata: json['arr_iata'] ?? '',
      depTime: json['dep_time'] ?? '',
      arrTime: json['arr_time'] ?? '',
      duration: (json['duration'] ?? 0).toDouble(),  // Ensure the correct type and use a default value
    );
  }
}
