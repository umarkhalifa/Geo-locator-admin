import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/map/presentation/providers/get_point_provider.dart';
import 'package:land_survey/features/map/presentation/providers/map_state_provider.dart';
import 'package:land_survey/features/map/presentation/widgets/land_map.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/sizes.dart';

class DistanceCard extends ConsumerWidget {
  final Future<void> Function(double lat, double long) locationFuture;

  const DistanceCard({
    super.key,
    required this.locationFuture,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(getPointsProvider).points;
    final polyIndex = ref.watch(markerIndex);
    final userLocation = ref.watch(mapNotifierProvider);
    return Positioned(
      bottom: 30,
      left: 15,
      right: 15,
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              points?[polyIndex].name ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
                "Northing: ${points?[polyIndex].northing},  Easting: ${points?[polyIndex].easting}"),
            Text(
                "Bearing: ${calculateInitialBearing(points?[polyIndex].latitude ?? 0, points?[polyIndex].longitude ?? 0, userLocation.latitude, userLocation.longitude).toStringAsFixed(3)}°"),
            Text("Height:${points?[polyIndex].height}"),
            const Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    final Uri googleMapsUrl = Uri.parse(
                        'https://www.google.com/maps/dir/?api=1&destination=${points?[polyIndex].latitude ?? 0},${points?[polyIndex].longitude ?? 0}');
                    if (await canLaunchUrl(googleMapsUrl)) {
                      await launchUrl(googleMapsUrl);
                    } else {
                      throw 'Could not launch Google Maps';
                    }
                  },
                  child: Container(
                    width: 140,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.blue,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          SolarIconsBold.routing2,
                          color: Colors.white,
                        ),
                        gapW8,
                        Text(
                          "Directions",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                gapW20,
                GestureDetector(
                  onTap: () {
                    locationFuture(points?[polyIndex].latitude ?? 0,
                        points?[polyIndex].longitude ?? 0);
                  },
                  child: Container(
                    width: 140,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.blue,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          SolarIconsBold.mapPoint,
                          color: Colors.white,
                        ),
                        gapW8,
                        Text(
                          "Navigate",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const radius = 6371.0; // Earth's radius in kilometers

  final dLat = _degreesToRadians(lat2 - lat1);
  final dLon = _degreesToRadians(lon2 - lon1);

  final a = sin(dLat / 2.0) * sin(dLat / 2.0) +
      cos(_degreesToRadians(lat1)) *
          cos(_degreesToRadians(lat2)) *
          sin(dLon / 2.0) *
          sin(dLon / 2.0);
  final c = 2.0 * atan2(sqrt(a), sqrt(1.0 - a));

  final distance = radius * c;

  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * (pi / 180);
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
