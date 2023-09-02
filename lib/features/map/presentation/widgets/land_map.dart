import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:land_survey/features/map/data/data_soucre/map_local_data_source.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';
import 'package:land_survey/features/map/presentation/providers/add_point_provider.dart';
import 'package:land_survey/features/map/presentation/providers/get_point_provider.dart';
import 'package:land_survey/features/map/presentation/providers/map_state_provider.dart';
import 'package:land_survey/features/map/presentation/widgets/map_bottom_sheet.dart';
import 'package:land_survey/features/map/presentation/widgets/map_type_widgets.dart';
import 'package:land_survey/features/map/presentation/widgets/markers_widget.dart';
import 'package:land_survey/features/map/presentation/widgets/navigation_widget.dart';
import 'package:land_survey/features/map/presentation/widgets/utm_coordinates_widgets.dart';
import 'package:land_survey/utils/map_type.dart';
import 'package:solar_icons/solar_icons.dart';

import '../../../../core/constants/sizes.dart';
import '../providers/map_data_state.dart';
import 'location_card.dart';

final markerIndex = StateProvider<int>((ref) => 0);

class LandMap extends ConsumerStatefulWidget {
  const LandMap({
    super.key,
    required this.mapState,
  });

  final MapDataState mapState;

  @override
  ConsumerState<LandMap> createState() => _LandMapState();
}

class _LandMapState extends ConsumerState<LandMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  ValueNotifier<LatLng> center = ValueNotifier(const LatLng(0.0, 0.0));
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();

  @override
  void initState() {
    super.initState();
    center.value = LatLng(widget.mapState.latitude, widget.mapState.longitude);
  }

  void updateMapPosition(CameraPosition position) {
    center.value = position.target;
  }

  @override
  Widget build(BuildContext context) {
    final pointState = ref.watch(getPointsProvider);
    bool showCompass = widget.mapState.showCompass;
    final polyIndex = ref.watch(markerIndex);
    return ValueListenableBuilder(
      valueListenable: center,
      builder: (context, value, child) {
        return Stack(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: GoogleMap(
                myLocationEnabled: true,
                mapType: widget.mapState.mapType.toType(),
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    widget.mapState.latitude,
                    widget.mapState.longitude,
                  ),
                  zoom: 15,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: pointState.markers,
                onCameraMove: updateMapPosition,
                onTap: (latLng) {
                  ref.read(addPointsProvider.notifier).addPoint(
                        LocationPoint(
                          latitude: latLng.latitude,
                          longitude: latLng.longitude,
                        ),
                      );
                },
                polylines: pointState.markers.isNotEmpty && showCompass
                    ? {
                        Polyline(
                          color: Colors.blue,
                          width: 4,
                          points: [
                            LatLng(
                                pointState.markers
                                    .elementAt(polyIndex)
                                    .position
                                    .latitude,
                                pointState.markers
                                    .elementAt(polyIndex)
                                    .position
                                    .longitude),
                            LatLng(value.latitude, value.longitude),
                          ],
                          polylineId: const PolylineId('poly'),
                        )
                      }
                    : {},
              ),
            ),
            if (pointState.markers.isNotEmpty && showCompass)
              DistanceCard(
                loc1: pointState.markers.elementAt(polyIndex).position,
                loc2: value,
              ),

            // const MapTypeIcon(),
            //
            // const MarkerIcon(),
            NavigationWidget(
              isCompass: showCompass,
              changeColor: widget.mapState.mapType == MyMapType.normal,
            ),
            // LocationCard(
            //   latController: TextEditingController(text: '${value.latitude}'),
            //   longController: TextEditingController(text: '${value.longitude}'),
            //   locationFuture: _updateMap,
            // ),
            Positioned(
              top: 70,
              right: 15,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet(
                        context: context,
                        builder: (context) => LandBottomSheet(
                              locationFuture: _updateMap,
                              latController: TextEditingController(
                                text: '${value.latitude}',
                              ),
                              longController: TextEditingController(
                                text: '${value.longitude}',
                              ),
                            ),
                        isScrollControlled: true);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      SolarIconsOutline.menuDots,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: switch (DateTime.now().isAfter(DateTime(2023, 08, 29))) {
                true => 0,
                false => 0
              },
              width: MediaQuery.sizeOf(context).width,
              color: Colors.transparent,
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateMap(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
  }
}

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
