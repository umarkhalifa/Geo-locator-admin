import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:land_survey/features/map/presentation/providers/get_point_provider.dart';
import 'package:land_survey/features/map/presentation/providers/map_state_provider.dart';
import 'package:land_survey/features/map/presentation/widgets/distance_card.dart';
import 'package:land_survey/features/map/presentation/widgets/map_bottom_sheet.dart';
import 'package:land_survey/features/map/presentation/widgets/navigation_widget.dart';
import 'package:land_survey/features/map/presentation/widgets/save_points_dialog.dart';
import 'package:land_survey/utils/map_type.dart';
import 'package:solar_icons/solar_icons.dart';

import '../providers/calculate_utm_provider.dart';
import '../providers/map_data_state.dart';

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
    return SafeArea(
      child: ValueListenableBuilder(
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
                  onTap: (value) {
                    ref.read(mapNotifierProvider.notifier).updateCompass(false);
                  },
                  markers: pointState.markers,
                  onCameraMove: updateMapPosition,
                ),
              ),
              if (pointState.markers.isNotEmpty && showCompass)
                DistanceCard(
                  locationFuture: _updateMap,
                ),
              NavigationWidget(
                changeColor: widget.mapState.mapType == MyMapType.normal,
              ),
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
                              useSafeArea: true,
                              builder: (context) => LandBottomSheet(
                                    locationFuture: _updateMap,
                                  ),
                              isScrollControlled: true)
                          .then((value) => ref
                              .read(getPointsProvider.notifier)
                              .resetSearch());
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
              Positioned(
                top: 120,
                right: 15,
                child: Visibility(
                  visible: ref.watch(calculateUtmNotifierProvider).showButton ??
                      true,
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (context) => const SavePointDialog());
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          SolarIconsOutline.mapPoint,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Future<void> _updateMap(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
  }
}
