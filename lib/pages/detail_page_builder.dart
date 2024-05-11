import 'package:flutter/material.dart';
import 'package:travelista_flutter/model/data_model.dart';
import 'package:travelista_flutter/widgets/app_large_text.dart';
import 'package:travelista_flutter/widgets/app_text.dart';
import 'package:travelista_flutter/misc/colors.dart';

class DetailPageBuilder {
  static Widget buildDetailPage(BuildContext context, DataModel place) {
    return Container(
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
                  image: NetworkImage("http://mark.bslmeiyu.com/uploads/" + place.img),
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
                Navigator.pop(context); // Go back to previous screen
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
                        text: place.name,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      AppLargeText(
                        text: "\$" + place.price.toString(),
                        color: AppColors.mainColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: AppColors.mainColor),
                      SizedBox(width: 5),
                      AppText(text: place.location, color: AppColors.textColor1),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: index < place.stars
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
                  // Remaining code for hotel details...
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
