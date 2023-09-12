import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:land_survey/core/constants/sizes.dart';
import 'package:land_survey/features/map/domain/entity/location_point.dart';
import 'package:land_survey/features/map/presentation/providers/add_point_provider.dart';
import 'package:land_survey/features/map/presentation/providers/calculate_utm_provider.dart';

class SavePointDialog extends HookConsumerWidget {
  const SavePointDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    return Dialog(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Text(
              "Save Point",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            gapH24,
            TextFormField(
              controller: nameController,
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
                  labelText: "Enter point name",
                  labelStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.w100)),
            ),
            gapH24,
            GestureDetector(
              onTap: () async {
                final point = ref.read(calculateUtmNotifierProvider);
                await ref
                    .read(addPointsProvider.notifier)
                    .addPoint(
                      LocationPoint(
                          latitude: point.latLng.latitude,
                          longitude: point.latLng.longitude,
                          northing: point.northing ?? 0,
                          easting: point.easting ?? 0,
                          zone: point.zone ?? 0,
                          band: point.band ?? '',
                          name: nameController.text,
                          height: point.height ?? 0),
                    )
                    .then((value) {
                  ref
                      .read(calculateUtmNotifierProvider.notifier)
                      .disAbleButton();
                  Navigator.pop(context);
                });
              },
              child: Container(
                height: 40,
                width: MediaQuery.sizeOf(context).width * 0.4,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: ref.watch(addPointsProvider).isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Save",
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
