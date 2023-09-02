import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solar_icons/solar_icons.dart';

class NavigationWidget extends StatelessWidget {
  final bool isCompass;
  final bool changeColor;

  const NavigationWidget(
      {super.key, required this.isCompass, required this.changeColor});

  @override
  Widget build(BuildContext context) {
    return switch (isCompass) {
      true => const Compass(),
      false => Center(
        child: Icon(
          SolarIconsOutline.gps, // Use any icon you prefer
          color: switch (changeColor) {
            true => const Color(0xff2d3e52),
            false => const Color(0XffFFFFFF)
          },
          size: 48.0,
        ),
      )
    };
  }
}
class Compass extends StatelessWidget {
  const Compass({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterCompass.events,
      builder: (BuildContext context, AsyncSnapshot<CompassEvent> snapshot) {
        if (snapshot.hasError) {
          return const Text('ERROR');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitRotatingCircle(
            color: Colors.green,
          );
        }
        double? direction = snapshot.data?.heading;
        if (direction == null) {
          return const Text("Enable location");
        }
        return Padding(
          padding: const EdgeInsets.all(130.0),
          child: AnimatedRotation(
            duration: const Duration(milliseconds: 500),
            turns: direction * (pi / 180) * -1,
            child: Center(
              child: SvgPicture.asset("assets/images/compass.svg"),
            ),
          ),
        );
      },
    );
  }
}
