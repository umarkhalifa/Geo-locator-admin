import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:land_survey/core/constants/sizes.dart';
import 'package:land_survey/features/map/presentation/widgets/location_card.dart';
import 'package:land_survey/features/map/presentation/widgets/map_type_widgets.dart';
import 'package:land_survey/features/map/presentation/widgets/markers_widget.dart';
import 'package:land_survey/features/map/presentation/widgets/utm_coordinates_widgets.dart';

class LandBottomSheet extends HookWidget {
  final TextEditingController latController;
  final TextEditingController longController;
  final Future<void> Function(double lat, double long) locationFuture;

  const LandBottomSheet({
    super.key,
    required this.locationFuture,
    required this.latController,
    required this.longController,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        padding:  EdgeInsets.only(left: 25,right: 25,top: 25, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LocationCard(
                  latController: latController,
                  longController: longController,
                  locationFuture: locationFuture),
              gapH24,
              const Divider(
                thickness: 0.4,
              ),
              const MapTypeIcon(),
              const Divider(
                thickness: 0.4,
              ),
              CalculateUtmIcon(
                locationFuture: locationFuture,
              ),
              const Divider(
                thickness: 0.4,
              ),
              const MarkerIcon(),
              gapH16,
              const MarkersBottomSheet(),
              gapH20,

            ],
          ),
        ),
      ),
    );
  }
}
