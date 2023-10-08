import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/core/constants/sizes.dart';
import 'package:land_survey/features/map/presentation/providers/get_point_provider.dart';
import 'package:land_survey/features/map/presentation/providers/map_state_provider.dart';
import 'package:land_survey/features/map/presentation/widgets/delete_dialog.dart';
import 'package:solar_icons/solar_icons.dart';

import 'land_map.dart';

class MarkerIcon extends ConsumerWidget {
  const MarkerIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
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
        ],
      ),
    );
  }
}

class MarkersBottomSheet extends ConsumerWidget {
  final Future<void> Function(double lat, double long)? locationFuture;

  const MarkersBottomSheet({
    super.key,
    this.locationFuture,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(getPointsProvider).searchPoints;
    return ListView.separated(
      itemBuilder: (context, index) {
        return GestureDetector(
          //DELETE POINT DIALOG
          onLongPress: () async {
            await showDialog(
                context: (context),
                builder: (context) {
                  return DeleteDialog(point: points?[index], index: index);
                });
          },
          //UPDATE MARKER INDEX
          onTap: () async {
            ref.read(markerIndex.notifier).state = index;
            ref.read(mapNotifierProvider.notifier).updateCompass(true);
            Navigator.pop(context);
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
                      "${points?[index].name}",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Northing: ${points?[index].northing}, ",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Easting: ${points?[index].easting}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Height: ${points?[index].height}",
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
      itemCount: points?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
