import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:travelista_flutter/cubit/app_cubit_logics.dart';
import 'package:travelista_flutter/cubit/app_cubits.dart';
import 'package:travelista_flutter/cubit/album_cubit.dart';
import 'package:travelista_flutter/pages/home_page.dart';
import 'package:travelista_flutter/pages/navpages/Booking_page.dart';
import 'package:travelista_flutter/pages/navpages/album_page.dart';
import 'package:travelista_flutter/pages/navpages/bar_item_page.dart';
import 'package:travelista_flutter/pages/navpages/login.dart';
import 'package:travelista_flutter/pages/navpages/my_page.dart';
import 'package:travelista_flutter/pages/navpages/search_page.dart';
import 'package:travelista_flutter/services/Favorite_Provider.dart';
import 'package:travelista_flutter/services/data_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensure Firebase is initialized

  runApp(
    MultiProvider(
      providers: [
        BlocProvider<AppCubits>(
          create: (context) => AppCubits(data: DataServices()),
        ),
        BlocProvider<AlbumCubit>(
          create: (context) => AlbumCubit(),
        ),ChangeNotifierProvider(
          create: (context) => BookingProvider(), // Add BookingProvider
        ), ChangeNotifierProvider(
      create: (context) => FavoriteProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
           home: LogIn(),
      //      BlocProvider(
      //   create: (context) => AppCubits(
      //     data: DataServices(),
      //   ),
      //   child: const AppCubitLogics(),
      // ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'), // Entry point with bottom nav
    );
  }
}




class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> pages = [
    HomePage(), // Using the HomePage widget from home_page.dart
    BarItemPage(),
    SearchPage(),
    MyPage(),
    AlbumPage(), // This should work now with AlbumProvider available
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex], // Select the current page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black45,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(label: "Challenges", icon: Icon(Icons.bar_chart_sharp)),
          BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: "Personal", icon: Icon(Icons.person)),
          BottomNavigationBarItem(label: "Albums", icon: Icon(Icons.photo_album)),
        ],
      ),
    );
  }
}

class BarItemPagee extends StatefulWidget {
const BarItemPagee({Key? key, required this.title}) : super(key: key);
final String title;
@override
_BarItemPageeState createState() => _BarItemPageeState();
}
class _BarItemPageeState extends State<MyHomePage> {
List<Widget> pages = [
HomePage(), // Using the HomePage widget from home_page.dart
BarItemPage(),
SearchPage(),
MyPage(),
AlbumPage(),
];

int currentIndex = 0;
void onTap(int index) {
setState(() {
currentIndex = index;
});
}
@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,
body: pages[currentIndex],
bottomNavigationBar: BottomNavigationBar(
type: BottomNavigationBarType.shifting,
backgroundColor: Colors.white,
onTap: onTap,
currentIndex: currentIndex,
selectedItemColor: Colors.black45,
unselectedItemColor: Colors.grey.withOpacity(0.5),
showSelectedLabels: true,
showUnselectedLabels: false,
items: const [
BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home_filled)),
BottomNavigationBarItem(label: "Challenges", icon: Icon(Icons.bar_chart_sharp)),
BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
BottomNavigationBarItem(label: "Personal", icon: Icon(Icons.person)),
BottomNavigationBarItem(label: "Albums", icon: Icon(Icons.photo_album)),
],
),
);
}
}






class SearchPagee extends StatefulWidget {
const SearchPagee({Key? key, required this.title}) : super(key: key);
final String title;
@override
_SearchPageeState createState() => _SearchPageeState();
}
class _SearchPageeState extends State<MyHomePage> {
List<Widget> pages = [
HomePage(), // Using the HomePage widget from home_page.dart
BarItemPage(),
SearchPage(),
MyPage(),
AlbumPage(),
];
int currentIndex = 0;
void onTap(int index) {
setState(() {
currentIndex = index;
});
}
@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,
body: pages[currentIndex],
bottomNavigationBar: BottomNavigationBar(
type: BottomNavigationBarType.shifting,
backgroundColor: Colors.white,
onTap: onTap,
currentIndex: currentIndex,
selectedItemColor: Colors.black45,
unselectedItemColor: Colors.grey.withOpacity(0.5),
showSelectedLabels: true,
showUnselectedLabels: false,
items: const [
BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home_filled)),
BottomNavigationBarItem(label: "Challenges", icon: Icon(Icons.bar_chart_sharp)),
BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
BottomNavigationBarItem(label: "Personal", icon: Icon(Icons.person)),
BottomNavigationBarItem(label: "Albums", icon: Icon(Icons.photo_album)),
],
),
);
}
}




class MyPagee extends StatefulWidget {
const MyPagee({Key? key, required this.title}) : super(key: key);
final String title;
@override
_MyPageeState createState() => _MyPageeState();
}
class _MyPageeState extends State<MyHomePage> {
List<Widget> pages = [
HomePage(), // Using the HomePage widget from home_page.dart
BarItemPage(),
SearchPage(),
MyPage(),
AlbumPage(),
];
int currentIndex = 0;
void onTap(int index) {
setState(() {
currentIndex = index;
});
}
@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,
body: pages[currentIndex],
bottomNavigationBar: BottomNavigationBar(
type: BottomNavigationBarType.shifting,
backgroundColor: Colors.white,
onTap: onTap,
currentIndex: currentIndex,
selectedItemColor: Colors.black45,
unselectedItemColor: Colors.grey.withOpacity(0.5),
showSelectedLabels: true,
showUnselectedLabels: false,
items: const [
BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home_filled)),
BottomNavigationBarItem(label: "Challenges", icon: Icon(Icons.bar_chart_sharp)),
BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
BottomNavigationBarItem(label: "Personal", icon: Icon(Icons.person)),
BottomNavigationBarItem(label: "Albums", icon: Icon(Icons.photo_album)),
],
),
);
}
}





class AlbumPagee extends StatefulWidget {
const AlbumPagee({Key? key, required this.title}) : super(key: key);
final String title;
@override
_AlbumPageeState createState() => _AlbumPageeState();
}
class _AlbumPageeState extends State<MyHomePage> {
List<Widget> pages = [
HomePage(), // Using the HomePage widget from home_page.dart
BarItemPage(),
SearchPage(),
MyPage(),
AlbumPage(),
];
int currentIndex = 0;
void onTap(int index) {
setState(() {
currentIndex = index;
});
}
@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,
body: pages[currentIndex],
bottomNavigationBar: BottomNavigationBar(
type: BottomNavigationBarType.shifting,
backgroundColor: Colors.white,
onTap: onTap,
currentIndex: currentIndex,
selectedItemColor: Colors.black45,
unselectedItemColor: Colors.grey.withOpacity(0.5),
showSelectedLabels: true,
showUnselectedLabels: false,
items: const [
BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home_filled)),
BottomNavigationBarItem(label: "Challenges", icon: Icon(Icons.bar_chart_sharp)),
BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
BottomNavigationBarItem(label: "Personal", icon: Icon(Icons.person)),
BottomNavigationBarItem(label: "Albums", icon: Icon(Icons.photo_album)),
],
),
);
}
}