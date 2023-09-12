import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/sizes.dart';

class DistanceCard extends StatelessWidget {
  final LatLng loc1;
  final LatLng loc2;

  const DistanceCard({super.key, required this.loc1, required this.loc2});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      left: 15,
      right: 15,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 70,
              // width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Distance",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                      "${calculateDistance(loc1.latitude, loc1.longitude, loc2.latitude, loc2.longitude).toStringAsFixed(6)} km"),
                ],
              ),
            ),
          ),
          gapW20,
          Expanded(
            child: Container(
              height: 70,
              // width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Bearing",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                      "${calculateInitialBearing(loc1.latitude, loc1.longitude, loc2.latitude, loc2.longitude).toStringAsFixed(6)}°"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

double calculateDistance(double lat1, double long1, double lat2, double long2) {
  const double earthRadius = 6371; // Earth's radius in kilometers

  double dLat = _degreesToRadians(lat2 - lat1);
  double dLong = _degreesToRadians(long2 - long1);

  double a = pow(sin(dLat / 2), 2) +
      cos(_degreesToRadians(lat1)) *
          cos(_degreesToRadians(lat2)) *
          pow(sin(dLong / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = earthRadius * c;
  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

double calculateInitialBearing(
    double lat1, double long1, double lat2, double long2) {
  double dLong = _degreesToRadians(long2 - long1);

  double y = sin(dLong) * cos(_degreesToRadians(lat2));
  double x = cos(_degreesToRadians(lat1)) * sin(_degreesToRadians(lat2)) -
      sin(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) * cos(dLong);

  double initialBearing = atan2(y, x);
  initialBearing = _radiansToDegrees(initialBearing);
  initialBearing = (initialBearing + 360) % 360; // Convert to 0-360 range
  return initialBearing;
}

double _radiansToDegrees(double radians) {
  return radians * 180 / pi;
}
