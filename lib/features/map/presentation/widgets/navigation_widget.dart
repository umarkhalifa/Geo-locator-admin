import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class NavigationWidget extends StatelessWidget {
  final bool changeColor;

  const NavigationWidget({super.key, required this.changeColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        SolarIconsOutline.gps, // Use any icon you prefer
        color: switch (changeColor) {
          true => const Color(0xff2d3e52),
          false => const Color(0XffFFFFFF)
        },
        size: 48.0,
      ),
    );
  }
}
