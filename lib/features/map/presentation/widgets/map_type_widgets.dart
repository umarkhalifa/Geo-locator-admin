import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land_survey/core/constants/sizes.dart';
import 'package:land_survey/features/map/presentation/providers/map_state_provider.dart';
import 'package:land_survey/utils/map_type.dart';
import 'package:solar_icons/solar_icons.dart';

class MapTypeIcon extends StatelessWidget {
  const MapTypeIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showDialog(
                context: context, builder: (context) => const MapTypeDialog())
            .then((value) => Navigator.pop(context));
      },
      child: Row(
        children: [
          const SizedBox(
            height: 45,
            width: 45,
            child: Icon(
              SolarIconsOutline.pointOnMap,
              color: Colors.blue,
              size: 30,
            ),
          ),
          gapW20,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Map Type",
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16, height: 1),
              ),
              Consumer(builder: (context, ref, child) {
                final type = ref.watch(mapNotifierProvider);
                return Text(type.mapType.toText());
              }),
            ],
          ),
          const Spacer(),
          const Icon(SolarIconsOutline.arrowRight),
        ],
      ),
    );
  }
}

class MapTypeDialog extends ConsumerWidget {
  const MapTypeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapType = ref.watch(mapNotifierProvider);
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 320,
          ),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Map Type",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 25,
                ),
                Column(
                  children: MyMapType.values.map((type) {
                    return SizedBox(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 50,
                            child: Radio(
                                value: type,
                                groupValue: mapType.mapType,
                                onChanged: (value) {
                                  ref
                                      .read(mapNotifierProvider.notifier)
                                      .updateMapType(value!);
                                  Navigator.pop(context);
                                },
                                activeColor: Colors.blue),
                          ),
                          Text(
                            type.toText(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
