import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:land_survey/core/constants/sizes.dart';
import 'package:land_survey/features/map/presentation/providers/delete_point_provider.dart';
import 'package:land_survey/features/map/presentation/providers/get_point_provider.dart';
import 'package:land_survey/features/map/presentation/providers/map_state_provider.dart';
import 'package:solar_icons/solar_icons.dart';

import 'land_map.dart';

class MarkerIcon extends ConsumerWidget {
  const MarkerIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      // onTap: () async {
      //   await showModalBottomSheet(
      //       context: context,
      //       builder: (context) => const MarkersBottomSheet(),
      //       isScrollControlled: true);
      // },
      child: Row(
        children: [
          const SizedBox(
            height: 45,
            width: 45,
            child: Icon(
              SolarIconsOutline.mapPoint,
              color: Colors.blue,
              size: 30,
            ),
          ),
          gapW20,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Mark Points",
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16, height: 1),
              ),
              Text(
                  "${ref.watch(getPointsProvider).markers.length} points marked")
            ],
          ),
          const Spacer(),
          Switch(
            value: ref.watch(mapNotifierProvider).showCompass,
            onChanged: (value) {
              ref.read(mapNotifierProvider.notifier).updateCompass();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

class MarkersBottomSheet extends ConsumerWidget {
  const MarkersBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = ref.watch(getPointsProvider);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 800),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            //DELETE POINT DIALOG
            onLongPress: () async {
              await showDialog(
                  context: (context),
                  builder: (context) {
                    return DeleteDialog(
                        marker: mapState.markers.elementAt(index),
                        index: index);
                  });
            },
            //UPDATE MARKER INDEX
            onTap: () {
              if (ref.read(mapNotifierProvider).showCompass) {
                ref.read(markerIndex.notifier).state = index;
                Navigator.pop(context);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue.withOpacity(0.1)),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(
                    SolarIconsBold.mapPoint,
                    color: Colors.blue,
                  ),
                  gapW20,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Marker Point ${index + 1}",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Latitude: ${mapState.markers.elementAt(index).position.latitude.toStringAsFixed(6)}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Longitude: ${mapState.markers.elementAt(index).position.longitude.toStringAsFixed(6)}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) {
          return gapH16;
        },
        itemCount: mapState.markers.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}

class DeleteDialog extends ConsumerWidget {
  final Marker marker;
  final int index;

  const DeleteDialog({super.key, required this.marker, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Delete point",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
                "Latitude: ${marker.position.latitude.toStringAsFixed(6)}\nLongitude: ${marker.position.longitude.toStringAsFixed(6)}"),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                //DELETE DIALOG
                //CHECK IF MARKERS HAS MORE THAN 1 VALUE SO THE INDEX CAN BE REDUCED TO ZERO
                if (ref.read(getPointsProvider).markers.length <= 2) {
                  ref.read(markerIndex.notifier).state = 0;
                }
                ref.read(deletePointsProvider.notifier).getPoints(index);
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue),
                child: const Center(
                  child: Text(
                    "Delete point",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
