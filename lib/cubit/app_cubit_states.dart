import 'package:equatable/equatable.dart';
import 'package:travelista_flutter/model/data_model.dart';

abstract class CubitStates extends Equatable {}

// Every app that uses Cubit should have an initial state (mandatory)
class InitialState extends CubitStates {
  @override
  List<Object?> get props => [];
}

class WelcomeState extends CubitStates {
  @override
  List<Object> get props => [];
}

class LoadingState extends CubitStates { // Triggered when trying to load data
  @override
  List<Object> get props => [];
}

class LoadedState extends CubitStates { // Triggered when data is successfully loaded
  LoadedState(this.places);
  final List<DataModel> places;

  @override
  List<Object> get props => [places]; // State is updated after being loaded
}

class DetailState extends CubitStates { // Triggered when data is successfully loaded
  DetailState(this.place);
  final DataModel place;

  @override
  List<Object> get props => [place]; // State is updated after being loaded
}

class LoggedInState extends CubitStates { // Added for login state handling
  @override
  List<Object?> get props => []; // Empty props list for now
}
