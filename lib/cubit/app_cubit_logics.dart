// app_cubits.dart (unchanged)

// app_cubit_states.dart (unchanged)

// app_cubit_logics.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelista_flutter/cubit/app_cubit_states.dart';
import 'package:travelista_flutter/cubit/app_cubits.dart';
import 'package:travelista_flutter/main.dart';
import 'package:travelista_flutter/pages/detail_page.dart';
import 'package:travelista_flutter/pages/navpages/login.dart'; // Replace with your login page widget

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({Key? key}) : super(key: key);

  @override
  _AppCubitLogicsState createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is DetailState) {
            return DetailPage();
          } else if (state is WelcomeState) {
            return LogIn(); // Navigate to login page in WelcomeState
          } else if (state is LoadedState) {
            return MyHomePage(title: 'Main Navigation');
          } else if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }  else if (state is LoggedInState) {
    return MyHomePage(title: 'Main Navigation'); // Navigate to MyHomePage after login
  } else {
            return Container();
          }
        },
      ),
    );
  }
}
