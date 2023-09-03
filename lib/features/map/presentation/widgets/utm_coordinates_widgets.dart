import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:land_survey/core/constants/sizes.dart';
import 'package:land_survey/features/map/presentation/providers/calculate_utm_provider.dart';
import 'package:solar_icons/solar_icons.dart';

class CalculateUtmIcon extends StatelessWidget {
  final Future<void> Function(double lat, double long) locationFuture;

  const CalculateUtmIcon({
    super.key,
    required this.locationFuture,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.pop(context);
        final location = await showDialog(
            context: context, builder: (context) => const UtmDialog());
        location != null
            ? locationFuture(location.latitude, location.longitude)
            : null;
      },
      child: const Row(
        children: [
          SizedBox(
            height: 45,
            width: 45,
            child: Icon(
              SolarIconsOutline.calculatorMinimalistic,
              color: Colors.blue,
              size: 30,
            ),
          ),
          gapW20,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Calculate coordinates",
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16, height: 1),
              ),
              Text("Latitude,Longitude"),
            ],
          ),
          Spacer(),
          Icon(SolarIconsOutline.arrowRight),
        ],
      ),
    );
  }
}

class UtmDialog extends HookConsumerWidget {
  const UtmDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myValue = ref.watch(calculateUtmNotifierProvider);
    final northController = useTextEditingController();
    final eastController = useTextEditingController();
    final zoneController = useTextEditingController();
    final bandController = useTextEditingController();
    return Dialog(
      child: Container(
        height: 380,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Search UTM (Universal Transverse Mercator)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 25,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                controller: eastController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0XFFf5f6fa),
                    constraints: BoxConstraints(maxHeight: 48),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintStyle:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w100),
                    hintText: "Enter Easting....."),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                controller: northController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0XFFf5f6fa),
                    constraints: BoxConstraints(maxHeight: 48),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Enter Northing.....",
                    hintStyle:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w100)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      controller: zoneController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0XFFf5f6fa),
                          constraints: BoxConstraints(maxHeight: 48),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w100),
                          hintText: "Enter Zone....."),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      controller: bandController,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0XFFf5f6fa),
                          constraints: BoxConstraints(maxHeight: 48),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w100),
                          hintText: "Enter band....."),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  await ref
                      .read(calculateUtmNotifierProvider.notifier)
                      .calculateUtm(
                          double.parse(northController.text.trim()),
                          double.parse(eastController.text.trim()),
                          int.parse(zoneController.text.trim()),
                          bandController.text.trim())
                      .then((value) {
                    Navigator.pop(
                        context, ref.read(calculateUtmNotifierProvider).latLng);
                  });
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: switch (myValue.isLoading) {
                    true => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 3),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    false => const Text(
                        "Search",
                        style: TextStyle(color: Colors.white),
                      )
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
