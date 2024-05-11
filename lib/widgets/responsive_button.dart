import 'package:flutter/material.dart';
import 'package:travelista_flutter/widgets/app_text.dart';

class ResponsiveButton extends StatelessWidget {
  final bool? isResponsive;
  final double? width;

  ResponsiveButton({Key? key, this.width = 120, this.isResponsive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: isResponsive == true ? double.maxFinite : width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF5d69b3),
        ),
        child: Row(
          mainAxisAlignment:
              isResponsive == true ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          children: [
            if (isResponsive == true)
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: AppText(
                  text: "Book Hotel Now",
                  color: Colors.white,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 130), // Shift the arrow to the left
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
