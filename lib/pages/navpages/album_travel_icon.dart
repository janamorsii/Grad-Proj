import 'package:flutter/material.dart';

// List of travel-related icons to choose from
final List<IconData> travelIcons = [
  Icons.airplanemode_active,
  Icons.work,
  Icons.beach_access,
  Icons.location_city,
  Icons.terrain,
  Icons.hotel,
  Icons.directions_car,
  Icons.directions_boat,
  Icons.place,
];

// Widget for selecting an icon from a predefined list
class SelectTravelIcon extends StatefulWidget {
  final Function(IconData) onIconSelected; // Callback for when an icon is selected
  final IconData defaultIcon; // Default icon to start with

  SelectTravelIcon({required this.onIconSelected, required this.defaultIcon});

  @override
  _SelectTravelIconState createState() => _SelectTravelIconState();
}

class _SelectTravelIconState extends State<SelectTravelIcon> {
  late IconData _selectedIcon; // State to track the currently selected icon

  @override
  void initState() {
    super.initState();
    _selectedIcon = widget.defaultIcon; // Start with the default icon
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: travelIcons.map((icon) {
        return IconButton(
          icon: Icon(icon),
          color: _selectedIcon == icon ? Colors.blue : Colors.grey, // Change color if selected
          onPressed: () {
            setState(() {
              _selectedIcon = icon; // Update the selected icon
            });
            widget.onIconSelected(icon); // Notify parent about the selection
          },
        );
      }).toList(),
    );
  }
}
