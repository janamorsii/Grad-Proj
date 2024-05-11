import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelista_flutter/cubit/app_cubit_states.dart';
import 'package:travelista_flutter/model/data_model.dart';
import 'package:travelista_flutter/pages/navpages/my_page.dart';
import 'package:travelista_flutter/services/data_services.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    checkUserAuth();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      emit(LoggedInState()); // Emit LoggedInState if user is already logged in on app launch
    }
  }

  final DataServices data;
  late List<DataModel> places;

  // Checks for changes in authentication state
  void checkUserAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // If no user is authenticated, transition to `WelcomeState`
        emit(WelcomeState());
        print("Transitioned to WelcomeState");
      } else {
        // If a user is authenticated, load data and transition to `LoadedState`
        getData();
      }
    });
  }

  void getData() async {
    try {
      emit(LoadingState()); // Show loading state
      places = await data.getInfo(); // Fetch data
      emit(LoadedState(places)); // After loading, transition to `LoadedState`
      print("Transitioned to LoadedState with ${places.length} items");
    } catch (e) {
      emit(WelcomeState()); // If there's an error, fallback to `WelcomeState`
      print("Error loading data: $e, transitioned to WelcomeState");
    }
  }

  void detailPage(DataModel data) {
    emit(DetailState(data)); // Transition to detail state
    print("Transitioned to DetailState");
  }
  // void addFavorite(String hotelName) {
  //   favoriteHotels.add(hotelName);
  //   // You may emit a state here if needed
  // }

  // void removeFavorite(String hotelName) {
  //   favoriteHotels.remove(hotelName);
  //   // You may emit a state here if needed
  // }

  // void addBooking(Map<String, dynamic> bookingDetails) {
  //   bookings.add(bookingDetails);
  //   // You may emit a state here if needed
  // }

  void goHome() {
    emit(LoadedState(places)); // Transition back to loaded state
    print("Transitioned back to LoadedState");
  }
  void logout() {
    FirebaseAuth.instance.signOut();
    emit(WelcomeState()); // Transition to WelcomeState after logout
  }
}
