import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/features/map/presentation/providers/get_point_provider.dart';
import 'package:land_survey/features/map/presentation/widgets/markers_widget.dart';

class LocationCard extends ConsumerWidget {
  final Future<void> Function(double lat, double long) locationFuture;

  const LocationCard({super.key, required this.locationFuture});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(getPointsProvider).points;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (text) {
                  ref.read(getPointsProvider.notifier).searchPoints(text);
                },
                decoration: const InputDecoration(
                    constraints: BoxConstraints(maxHeight: 48),
                    border: OutlineInputBorder(),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    hintText: "Search point name",
                    hintStyle:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w100)),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        MarkersBottomSheet(
          locationFuture: locationFuture,
        ),
      ],
    );
  }
}
