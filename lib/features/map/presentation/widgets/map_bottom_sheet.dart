import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:land_survey/core/constants/sizes.dart';
import 'package:land_survey/features/map/presentation/widgets/location_card.dart';
import 'package:land_survey/features/map/presentation/widgets/map_type_widgets.dart';
import 'package:land_survey/features/map/presentation/widgets/markers_widget.dart';
import 'package:land_survey/features/map/presentation/widgets/users.dart';
import 'package:land_survey/features/map/presentation/widgets/utm_coordinates_widgets.dart';
import 'package:solar_icons/solar_icons.dart';

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
        padding: EdgeInsets.only(
            left: 25,
            right: 25,
            top: 25,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            children: [
              gapH12,
              Row(
                children: [
                  const Spacer(),
                  const Text(
                    "Navigation Tools",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(SolarIconsOutline.closeSquare),
                  ),
                ],
              ),
              gapH24,
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
              const UsersIcon(),
              const Divider(
                thickness: 0.4,
              ),
              const MarkerIcon(),
              gapH16,
              MarkersBottomSheet(
                locationFuture: locationFuture,
              ),
              const Divider(
                thickness: 0.4,
              ),
              const LogoutIcon(),
              gapH20,
            ],
          ),
        ),
      ),
    );
  }
}

class LogoutIcon extends StatelessWidget {
  const LogoutIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FirebaseAuth.instance.signOut(),
      child: Row(
        children: [
          const SizedBox(
            height: 45,
            width: 45,
            child: Icon(
              SolarIconsOutline.logout_2,
              color: Colors.red,
              size: 30,
            ),
          ),
          gapW20,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Logout",
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16, height: 1),
              ),
              Text(FirebaseAuth.instance.currentUser?.email ?? '')
            ],
          ),
        ],
      ),
    );
  }
}
