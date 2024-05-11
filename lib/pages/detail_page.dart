import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:travelista_flutter/cubit/app_cubit_states.dart';
import 'package:travelista_flutter/cubit/app_cubits.dart';
import 'package:travelista_flutter/misc/colors.dart';
import 'package:travelista_flutter/pages/navpages/Booking_page.dart';
import 'package:travelista_flutter/services/Favorite_Provider.dart';
import 'package:travelista_flutter/widgets/app_buttons.dart';
import 'package:travelista_flutter/widgets/app_large_text.dart';
import 'package:travelista_flutter/widgets/app_text.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedIndex = -1;

  void bookHotel(String hotelName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingPage(hotelName: hotelName),
      ),
    ).then((result) {
      if (result != null) {
        final bookingDetails = result as Map<String, dynamic>;
        // Add booking details to the list (if needed)
      }
    });
  }

  void toggleFavorite(String hotelName) {
    final isFavorite = Provider.of<FavoriteProvider>(context, listen: false).favoriteHotels.contains(hotelName);
    if (isFavorite) {
      Provider.of<FavoriteProvider>(context, listen: false).removeFavorite(hotelName);
    } else {
      Provider.of<FavoriteProvider>(context, listen: false).addFavorite(hotelName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      DetailState detail = state as DetailState;

      return Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("http://mark.bslmeiyu.com/uploads/" + detail.place.img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                child: IconButton(
                  onPressed: () {
                    BlocProvider.of<AppCubits>(context).goHome();
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 300,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 700,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppLargeText(
                            text: detail.place.name,
                            color: Colors.black.withOpacity(0.8),
                          ),
                          AppLargeText(
                            text: "\$" + detail.place.price.toString(),
                            color: AppColors.mainColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: AppColors.mainColor),
                          SizedBox(width: 5),
                          AppText(text: detail.place.location, color: AppColors.textColor1),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: index < detail.place.stars
                                    ? AppColors.starColor
                                    : AppColors.textColor2,
                              );
                            }),
                          ),
                          SizedBox(width: 10),
                          AppText(text: "(5.0)", color: AppColors.textColor2),
                        ],
                      ),
                      SizedBox(height: 25),
                      AppLargeText(
                        text: "People",
                        color: Colors.black.withOpacity(0.8),
                        size: 20,
                      ),
                      SizedBox(height: 5),
                      AppText(text: "Number of people in your group", color: AppColors.mainTextColor),
                      SizedBox(height: 10),
                      Wrap(
                        children: List.generate(5, (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: AppButtons(
                                size: 50,
                                color: selectedIndex == index ? Colors.white : Colors.black,
                                backgroundColor: selectedIndex == index ? Colors.black : AppColors.buttonBackground,
                                borderColor: selectedIndex == index ? Colors.black : AppColors.buttonBackground,
                                text: (index + 1).toString(),
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 20),
                      AppLargeText(
                        text: "Description",
                        color: Colors.black.withOpacity(0.8),
                        size: 20,
                      ),
                      SizedBox(height: 10),
                      AppText(text: detail.place.description, color: AppColors.mainTextColor),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => toggleFavorite(detail.place.name),
                            icon: Icon(
                              Provider.of<FavoriteProvider>(context).favoriteHotels.contains(detail.place.name)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => bookHotel(detail.place.name),
                            child: Text("Book Hotel Now"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
