import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelista_flutter/cubit/app_cubit_states.dart';
import 'package:travelista_flutter/cubit/app_cubits.dart';
import 'package:travelista_flutter/model/data_model.dart';
import 'package:travelista_flutter/services/data_services.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  late List<DataModel> _hotels;
  late List<DataModel> _filteredHotels;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _hotels = [];
    _filteredHotels = [];
    _fetchHotels();
  }

  Future<void> _fetchHotels() async {
    try {
      DataServices dataServices = DataServices();
      List<DataModel> hotels = await dataServices.getInfo();
      setState(() {
        _hotels = hotels;
        _filteredHotels = hotels;
      });
    } catch (e) {
      print("Error fetching hotels: $e");
    }
  }

  List<DataModel> _filterHotels(List<DataModel> hotels, String query) {
    if (query.isEmpty) {
      return hotels; // Return all hotels if query is empty
    } else {
      return hotels.where((hotel) =>
          hotel.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredHotels = _filterHotels(_hotels, query);
    });
  }

  void _onHotelSelected(DataModel hotel) {
    BlocProvider.of<AppCubits>(context).emit(DetailState(hotel));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Hotels'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search by hotel name...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredHotels.length,
              itemBuilder: (context, index) {
                final hotel = _filteredHotels[index];
                return ListTile(
                  title: Text(hotel.name),
                  subtitle: Text(hotel.location),
                  onTap: () => _onHotelSelected(hotel),
                  // Add more details of the hotel as needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
