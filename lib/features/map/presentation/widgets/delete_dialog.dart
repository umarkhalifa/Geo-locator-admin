import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';
import 'package:land_survey/features/map/presentation/providers/delete_point_provider.dart';
import 'package:land_survey/features/map/presentation/providers/get_point_provider.dart';
import 'package:land_survey/features/map/presentation/widgets/land_map.dart';

class DeleteDialog extends ConsumerWidget {
  final LocationPoint? point;
  final int index;

  const DeleteDialog({super.key, required this.point, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Container(
        height: 200,
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
            Text("${point?.name}"),
            Text(
                "Northing: ${point?.northing.toStringAsFixed(6)}\nEasting: ${point?.easting.toStringAsFixed(6)}"),
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
